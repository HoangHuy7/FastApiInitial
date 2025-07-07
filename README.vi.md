# Dự án FastAPI - Backend

## Yêu cầu

* [Docker](https://www.docker.com/).
* [uv](https://docs.astral.sh/uv/) để quản lý gói và môi trường Python.

## Docker Compose

Khởi động môi trường phát triển cục bộ với Docker Compose theo hướng dẫn trong [../development.md](../development.md).

## Quy trình làm việc chung

Theo mặc định, các phụ thuộc được quản lý bằng [uv](https://docs.astral.sh/uv/), hãy truy cập và cài đặt nó.

Từ `./backend/`, bạn có thể cài đặt tất cả các phụ thuộc bằng lệnh:

```console
$ uv sync
```

Sau đó, bạn có thể kích hoạt môi trường ảo bằng lệnh:

```console
$ source .venv/bin/activate
```

Hãy chắc chắn rằng trình soạn thảo của bạn đang sử dụng đúng môi trường ảo Python, với trình thông dịch tại `backend/.venv/bin/python`.

Sửa đổi hoặc thêm các mô hình SQLModel cho dữ liệu và bảng SQL trong `./backend/app/models.py`, các điểm cuối API trong `./backend/app/api/`, các tiện ích CRUD (Tạo, Đọc, Cập nhật, Xóa) trong `./backend/app/crud.py`.

## VS Code

Đã có sẵn các cấu hình để chạy backend thông qua trình gỡ lỗi của VS Code, để bạn có thể sử dụng các điểm dừng, tạm dừng và khám phá các biến, v.v.

Thiết lập cũng đã được định cấu hình để bạn có thể chạy các bài kiểm tra thông qua tab kiểm tra Python của VS Code.

## Ghi đè Docker Compose

Trong quá trình phát triển, bạn có thể thay đổi các cài đặt Docker Compose sẽ chỉ ảnh hưởng đến môi trường phát triển cục bộ trong tệp `docker-compose.override.yml`.

Các thay đổi đối với tệp đó chỉ ảnh hưởng đến môi trường phát triển cục bộ, không phải môi trường sản xuất. Vì vậy, bạn có thể thêm các thay đổi "tạm thời" giúp cho quy trình phát triển.

Ví dụ, thư mục chứa mã backend được đồng bộ hóa trong bộ chứa Docker, sao chép mã bạn thay đổi trực tiếp vào thư mục bên trong bộ chứa. Điều đó cho phép bạn kiểm tra các thay đổi của mình ngay lập tức mà không cần phải xây dựng lại hình ảnh Docker. Nó chỉ nên được thực hiện trong quá trình phát triển, đối với sản xuất, bạn nên xây dựng hình ảnh Docker với phiên bản mã backend gần đây. Nhưng trong quá trình phát triển, nó cho phép bạn lặp lại rất nhanh.

Cũng có một ghi đè lệnh chạy `fastapi run --reload` thay vì `fastapi run` mặc định. Nó khởi động một quy trình máy chủ duy nhất (thay vì nhiều, như đối với sản xuất) và tải lại quy trình bất cứ khi nào mã thay đổi. Hãy nhớ rằng nếu bạn có lỗi cú pháp và lưu tệp Python, nó sẽ bị hỏng và thoát, và bộ chứa sẽ dừng lại. Sau đó, bạn có thể khởi động lại bộ chứa bằng cách sửa lỗi và chạy lại:

```console
$ docker compose watch
```

Cũng có một ghi đè `command` được nhận xét, bạn có thể bỏ ghi chú nó và nhận xét cái mặc định. Nó làm cho bộ chứa backend chạy một quy trình không làm "gì cả", nhưng giữ cho bộ chứa hoạt động. Điều đó cho phép bạn vào bên trong bộ chứa đang chạy của mình và thực thi các lệnh bên trong, ví dụ như một trình thông dịch Python để kiểm tra các phụ thuộc đã cài đặt hoặc khởi động máy chủ phát triển tải lại khi phát hiện thay đổi.

Để vào bên trong bộ chứa bằng một phiên `bash`, bạn có thể khởi động ngăn xếp bằng lệnh:

```console
$ docker compose watch
```

và sau đó trong một thiết bị đầu cuối khác, `exec` vào bên trong bộ chứa đang chạy:

```console
$ docker compose exec backend bash
```

Bạn sẽ thấy một đầu ra như:

```console
root@7f2607af31c3:/app#
```

điều đó có nghĩa là bạn đang ở trong một phiên `bash` bên trong bộ chứa của mình, với tư cách là người dùng `root`, trong thư mục `/app`, thư mục này có một thư mục khác tên là "app" bên trong, đó là nơi mã của bạn tồn tại bên trong bộ chứa: `/app/app`.

Ở đó, bạn có thể sử dụng lệnh `fastapi run --reload` để chạy máy chủ tải lại trực tiếp gỡ lỗi.

```console
$ fastapi run --reload app/main.py
```

... nó sẽ trông như thế này:

```console
root@7f2607af31c3:/app# fastapi run --reload app/main.py
```

và sau đó nhấn enter. Thao tác đó sẽ chạy máy chủ tải lại trực tiếp tự động tải lại khi phát hiện thay đổi mã.

Tuy nhiên, nếu nó không phát hiện ra thay đổi mà là lỗi cú pháp, nó sẽ chỉ dừng lại với một lỗi. Nhưng vì bộ chứa vẫn đang hoạt động và bạn đang ở trong một phiên Bash, bạn có thể nhanh chóng khởi động lại nó sau khi sửa lỗi, chạy cùng một lệnh ("mũi tên lên" và "Enter").

... chi tiết trước đó này là điều làm cho việc giữ cho bộ chứa hoạt động không làm gì cả và sau đó, trong một phiên Bash, làm cho nó chạy máy chủ tải lại trực tiếp trở nên hữu ích.

## Kiểm tra backend

Để kiểm tra backend, hãy chạy:

```console
$ bash ./scripts/test.sh
```

Các bài kiểm tra chạy bằng Pytest, sửa đổi và thêm các bài kiểm tra vào `./backend/app/tests/`.

Nếu bạn sử dụng GitHub Actions, các bài kiểm tra sẽ chạy tự động.

### Ngăn xếp chạy thử nghiệm

Nếu ngăn xếp của bạn đã hoạt động và bạn chỉ muốn chạy các bài kiểm tra, bạn có thể sử dụng:

```bash
docker compose exec backend bash scripts/tests-start.sh
```

Tập lệnh `/app/scripts/tests-start.sh` đó chỉ gọi `pytest` sau khi đảm bảo rằng phần còn lại của ngăn xếp đang chạy. Nếu bạn cần chuyển các đối số bổ sung cho `pytest`, bạn có thể chuyển chúng vào lệnh đó và chúng sẽ được chuyển tiếp.

Ví dụ, để dừng ở lỗi đầu tiên:

```bash
docker compose exec backend bash scripts/tests-start.sh -x
```

### Phạm vi kiểm tra

Khi các bài kiểm tra được chạy, một tệp `htmlcov/index.html` được tạo, bạn có thể mở nó trong trình duyệt của mình để xem phạm vi của các bài kiểm tra.

## Di chuyển

Vì trong quá trình phát triển cục bộ, thư mục ứng dụng của bạn được gắn dưới dạng một ổ đĩa bên trong bộ chứa, bạn cũng có thể chạy các di chuyển bằng các lệnh `alembic` bên trong bộ chứa và mã di chuyển sẽ nằm trong thư mục ứng dụng của bạn (thay vì chỉ ở bên trong bộ chứa). Vì vậy, bạn có thể thêm nó vào kho lưu trữ git của mình.

Hãy chắc chắn rằng bạn tạo một "bản sửa đổi" của các mô hình của mình và bạn "nâng cấp" cơ sở dữ liệu của mình với bản sửa đổi đó mỗi khi bạn thay đổi chúng. Vì đây là những gì sẽ cập nhật các bảng trong cơ sở dữ liệu của bạn. Nếu không, ứng dụng của bạn sẽ có lỗi.

* Bắt đầu một phiên tương tác trong bộ chứa backend:

```console
$ docker compose exec backend bash
```

* Alembic đã được định cấu hình để nhập các mô hình SQLModel của bạn từ `./backend/app/models.py`.

* Sau khi thay đổi một mô hình (ví dụ: thêm một cột), bên trong bộ chứa, hãy tạo một bản sửa đổi, ví dụ:

```console
$ alembic revision --autogenerate -m "Thêm cột last_name vào mô hình Người dùng"
```

* Cam kết vào kho lưu trữ git các tệp được tạo trong thư mục alembic.

* Sau khi tạo bản sửa đổi, hãy chạy di chuyển trong cơ sở dữ liệu (đây là những gì sẽ thực sự thay đổi cơ sở dữ liệu):

```console
$ alembic upgrade head
```

Nếu bạn hoàn toàn không muốn sử dụng di chuyển, hãy bỏ ghi chú các dòng trong tệp tại `./backend/app/core/db.py` kết thúc bằng:

```python
SQLModel.metadata.create_all(engine)
```

và nhận xét dòng trong tệp `scripts/prestart.sh` có chứa:

```console
$ alembic upgrade head
```

Nếu bạn không muốn bắt đầu với các mô hình mặc định và muốn xóa/sửa đổi chúng ngay từ đầu mà không có bất kỳ bản sửa đổi nào trước đó, bạn có thể xóa các tệp sửa đổi (tệp Python `.py`) trong `./backend/app/alembic/versions/`. Và sau đó tạo một di chuyển đầu tiên như được mô tả ở trên.

## Mẫu email

Các mẫu email nằm trong `./backend/app/email-templates/`. Ở đây, có hai thư mục: `build` và `src`. Thư mục `src` chứa các tệp nguồn được sử dụng để xây dựng các mẫu email cuối cùng. Thư mục `build` chứa các mẫu email cuối cùng được ứng dụng sử dụng.

Trước khi tiếp tục, hãy đảm bảo bạn đã cài đặt [tiện ích mở rộng MJML](https://marketplace.visualstudio.com/items?itemName=attilabuti.vscode-mjml) trong VS Code của mình.

Khi bạn đã cài đặt tiện ích mở rộng MJML, bạn có thể tạo một mẫu email mới trong thư mục `src`. Sau khi tạo mẫu email mới và với tệp `.mjml` đang mở trong trình chỉnh sửa của bạn, hãy mở bảng lệnh bằng `Ctrl+Shift+P` và tìm kiếm `MJML: Export to HTML`. Thao tác này sẽ chuyển đổi tệp `.mjml` thành tệp `.html` và bây giờ bạn có thể lưu nó vào thư mục build.
