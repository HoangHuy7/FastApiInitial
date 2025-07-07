FROM python:3.12-slim

# Cài đặt các công cụ cần thiết
RUN apt-get update && apt-get install -y curl build-essential && rm -rf /var/lib/apt/lists/*

# Cài uv từ PyPI
RUN pip install uv

# Tạo thư mục app
WORKDIR /app

# Copy toàn bộ project
COPY . /app

# Cài dependencies từ pyproject.toml
RUN uv pip install --system .

# Mở cổng
EXPOSE 8000

# Chạy app
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
