FROM golang:1.19

#RUN apk add --no-cache git

WORKDIR /app/go-rest-mux

# We want to populate the module cache based on the go.{mod,sum} files.
COPY go.mod .
COPY go.sum .

ENV GOPROXY=direct
RUN go mod download

COPY main.go .
COPY model.go .
COPY main_test.go .


# Build the Go app
RUN go build -o ./out/go-rest-mux .


# This container exposes port 8080 to the outside world
EXPOSE 8080
# Run the binary program produced by `go install`
CMD ["./out/go-rest-mux"]