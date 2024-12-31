# FROM golang:1.22.5 as base
# WORKDIR /app
# COPY go.mod .
# RUN go mod download

# COPY . .

# RUN go build -o main .

# # final stage

# FROM alpine:latest
# RUN apk add --no-cache bash # Install bash
# COPY --from=base /app/main  .
# COPY --from=base /app/static ./static 
# EXPOSE 8080 
# CMD ["/bin/bash", "-c", "chmod +x ./main;./main"] 


# Build stage
FROM golang:1.22.5 as base
WORKDIR /app
COPY go.mod .
RUN go mod download
COPY . .
RUN go build -o main .

# Final stage
FROM busybox:latest
WORKDIR /app
#RUN apk add --no-cache bash # Install bash
COPY --from=base /app/main .
COPY --from=base /app/static ./static
RUN ls -l
EXPOSE 8080
CMD ["./main"]
