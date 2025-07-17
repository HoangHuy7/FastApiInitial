# FastAPI Initializr (Bản Tiếng Việt)

Chào mừng bạn đến với dự án FastAPI mới! Dự án này được thiết kế như một điểm khởi đầu vững chắc để xây dựng các API web hiện đại, có khả năng mở rộng và sẵn sàng cho môi trường production với Python. Lấy cảm hứng từ sự tiện lợi của Spring Initializr, dự án cung cấp một cấu trúc rõ ràng, các tính năng thiết yếu và các công cụ được cấu hình sẵn để bạn có thể bắt đầu chỉ trong vài phút.

## ✨ Tính năng

*   **Công nghệ Hiện đại**: Xây dựng trên nền tảng FastAPI, Pydantic, và SQLModel để mang lại trải nghiệm phát triển tốt nhất.
*   **Quản lý Người dùng**: Hệ thống xác thực và phân quyền người dùng đầy đủ, bao gồm:
    *   Đăng ký người dùng
    *   Đăng nhập bằng JWT
    *   Khôi phục mật khẩu
    *   Tạo superuser
*   **Tích hợp Cơ sở dữ liệu**: Đi kèm với SQLModel cho việc tương tác với cơ sở dữ liệu một cách trực quan và mạnh mẽ, được cấu hình sẵn cho PostgreSQL.
*   **Hỗ trợ Bất đồng bộ**: Hoàn toàn bất đồng bộ, từ cơ sở dữ liệu đến các API endpoint.
*   **Thông báo qua Email**: Gửi email được cấu hình sẵn cho các hành động của người dùng như đăng ký và đặt lại mật khẩu, với các mẫu email đẹp mắt từ MJML.
*   **Quản lý Gói phụ thuộc**: Sử dụng `uv` để quản lý các gói phụ thuộc một cách nhanh chóng và đáng tin cậy.
*   **Containerization**: Bao gồm `Dockerfile` để dễ dàng đóng gói và triển khai ứng dụng.
*   **Công cụ Hỗ trợ**: Được cấu hình sẵn với `ruff` để linting và `mypy` để kiểm tra kiểu tĩnh.

## 🚀 Công nghệ sử dụng

*   **Backend**: FastAPI, Uvicorn
*   **Cơ sở dữ liệu**: PostgreSQL, SQLModel
*   **Xác thực Dữ liệu**: Pydantic
*   **Xác thực**: Passlib (để băm mật khẩu), PyJWT (cho JWT token)
*   **Mẫu Email**: Jinja2, MJML
*   **Quản lý Gói phụ thuộc**: `uv`
*   **Containerization**: Docker

## ⚙️ Cài đặt và Cấu hình

### 1. Yêu cầu

*   Python 3.10+
*   Docker (tùy chọn, để triển khai bằng container)
*   Một instance của PostgreSQL đang chạy

### 2. Cài đặt

1.  **Clone repository:**
    ```bash
    git clone https://github.com/HoangHuy7/FastApiInitial.git
    cd FastAPIInitial
    ```

2.  **Tạo file môi trường:**
    Sao chép file `.env.example` thành `.env` và cập nhật các biến với thông tin cấu hình của bạn (thông tin đăng nhập cơ sở dữ liệu, secret key, v.v.).
    ```bash
    cp .env.example .env
    ```

3.  **Cài đặt các gói phụ thuộc:**
    Sử dụng `uv`, bạn có thể cài đặt tất cả các gói phụ thuộc cần thiết bằng một lệnh duy nhất:
    ```bash
    uv pip install --system .
    ```

### 3. Chạy Ứng dụng

*   **Chế độ Phát triển:**
    Để phát triển, bạn có thể chạy ứng dụng với tính năng tự động tải lại khi có thay đổi:
    ```bash
    uvicorn app.main:app --reload
    ```
    API sẽ có sẵn tại `http://127.0.0.1:8000`.

*   **Production (Docker):**
    Để build và chạy ứng dụng bằng Docker:
    ```bash
    docker build -t my-fastapi-app .
    docker run -d -p 8000:8000 --env-file .env my-fastapi-app
    ```

### Build Docker Image

Bạn cũng có thể build Docker image một cách riêng biệt bằng lệnh sau:

```bash
docker build -t fastapi-initial .
```

Lệnh này sẽ tạo ra một Docker image có tên `fastapi-initial` dựa trên `Dockerfile` được cung cấp. Sau đó, bạn có thể chạy image này bằng lệnh `docker run` như trong phần "Production (Docker)".

## Xem trước API

Đây là một vài ví dụ về các API endpoint có sẵn. Bạn có thể tìm thấy nhiều hơn trong file `test_main.http`.

### Đăng ký Người dùng

**Yêu cầu:**
`POST /api/v1/users/`
```json
{
  "email": "user@example.com",
  "password": "a_strong_password",
  "full_name": "John Doe"
}
```

### Lấy Access Token

**Yêu cầu:**
`POST /api/v1/login/access-token`
```json
{
  "username": "user@example.com",
  "password": "a_strong_password"
}
```

**Phản hồi:**
```json
{
  "access_token": "your-jwt-token",
  "token_type": "bearer"
}
```

### Lấy Thông tin Người dùng Hiện tại

**Yêu cầu:**
`GET /api/v1/users/me`
`Authorization: Bearer <your-jwt-token>`

**Phản hồi:**
```json
{
  "email": "user@example.com",
  "full_name": "John Doe",
  "is_active": true,
  "is_superuser": false
}
```

---

Chúc bạn có những trải nghiệm tuyệt vời khi xây dựng cùng FastAPI Initializr. Happy coding! 🚀