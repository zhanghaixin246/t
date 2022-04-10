package core

import (
	"fmt"
	"github.com/fvbock/endless"
	"github.com/gin-gonic/gin"
	"t/oversea/initialize"
	"time"
)

func initServer(address string, router *gin.Engine) server {
	s := endless.NewServer(address, router)
	s.ReadHeaderTimeout = 20 * time.Second
	s.WriteTimeout = 20 * time.Second
	s.MaxHeaderBytes = 1 << 20
	return s
}

type server interface {
	ListenAndServe() error
}

func RunServer() {

	address := fmt.Sprintf(":%d", 8888)
	router := initialize.Routers()
	s := initServer(address, router)

	fmt.Println(s.ListenAndServe().Error())
}
