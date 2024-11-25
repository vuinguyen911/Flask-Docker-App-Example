# Sử dụng image chính thức của Python
FROM python:3.9-slim

# Thiết lập thư mục làm việc
WORKDIR /app

# Sao chép file requirements.txt và cài đặt các dependencies
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

# Sao chép mã nguồn của ứng dụng vào container
COPY . .

# Expose port mà ứng dụng Flask sẽ chạy trên
EXPOSE 5000

# Định nghĩa lệnh để chạy ứng dụng
CMD ["python", "app.py"]
