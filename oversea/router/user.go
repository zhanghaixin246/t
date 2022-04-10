package router

import (
	"github.com/gin-gonic/gin"
	"t/oversea/api"
)

type UserRouter struct{}

func (u *UserRouter) InitUserRouter(Router *gin.RouterGroup) {

	userRouter := Router.Group("")
	baseApi := api.GroupApp.BaseApi
	{
		userRouter.POST("/captcha", baseApi.Captcha)
	}

}
