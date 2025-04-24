FROM alpine:3.18

# Установка Nginx
RUN apk add --no-cache nginx

# Создание директории для HTML-файлов
RUN mkdir -p /usr/share/nginx/html

# Копирование index.html из директории сборки (предполагается, что он скопирован из /home/vagrant/)
COPY index.html /usr/share/nginx/html/index.html

# Создание конфигурации Nginx
RUN echo 'server { \
        listen 80; \
        server_name localhost; \
        root /usr/share/nginx/html; \
        index index.html; \
        location / { \
            try_files $uri $uri/ /index.html; \
        } \
    }' > /etc/nginx/http.d/default.conf

# Настройка прав
RUN chown -R nginx:nginx /usr/share/nginx/html && \
    chmod -R 755 /usr/share/nginx/html

# Открытие порта
EXPOSE 80

# Запуск Nginx в foreground
CMD ["nginx", "-g", "daemon off;"]