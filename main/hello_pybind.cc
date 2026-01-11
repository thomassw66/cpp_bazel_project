#include <Eigen/Dense>
#include <format>
#include <pybind11/pybind11.h>

namespace py = pybind11;

PYBIND11_MODULE(hello_pybind, module) {
  module.def("add", [](int a, int b) { return a + b; });

  using Matrix = Eigen::MatrixXd;
  using Scalar = Matrix::Scalar;

  constexpr bool rowMajor = Matrix::Flags & Eigen::RowMajorBit;

  py::class_<Matrix>(module, "Matrix", py::buffer_protocol())
      .def(py::init([](py::buffer b) {
        using Strides = Eigen::Stride<Eigen::Dynamic, Eigen::Dynamic>;
        py::buffer_info info = b.request();

        if (info.format != py::format_descriptor<Scalar>::format()) {
          throw std::runtime_error{
              std::format("Incompatible format: expected a double array!")};
        }

        if (info.ndim != 2) {
          throw std::runtime_error(
              std::format("Incompatible buffer dimension!"));
        }

        auto strides = Strides(
            info.strides[rowMajor ? 0 : 1] / (py::ssize_t)sizeof(Scalar),
            info.strides[rowMajor ? 1 : 0] / (py::ssize_t)sizeof(Scalar));

        auto map = Eigen::Map<Matrix, 0, Strides>(
            static_cast<Scalar *>(info.ptr), info.shape[0], info.shape[1],
            strides);

        return Matrix(map);
      }))
      .def_buffer([](Matrix &m) -> py::buffer_info {
        return py::buffer_info(m.data(), sizeof(Scalar),
                               py::format_descriptor<Scalar>::format(), 2,
                               {m.rows(), m.cols()},
                               {sizeof(Scalar) * (rowMajor ? m.cols() : 1),
                                sizeof(Scalar) * (rowMajor ? 1 : m.rows())});
      })
      .def("__repr__", [](const Matrix &m) {
        std::stringstream ss;
        ss << m;
        return ss.str();
      });
}
