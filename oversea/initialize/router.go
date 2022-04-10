package initialize

import (
	"github.com/gin-gonic/gin"
	"t/oversea/router"
)

func Routers() *gin.Engine {
	Router := gin.Default()

	PublicGroup := Router.Group("")
	{
		PublicGroup.GET("/", func(c *gin.Context) {
			c.JSON(200, "oversea")
		})
	}
	systemRouter := new(router.SystemRouterGroup)
	systemRouter.InitUserRouter(Router.Group(""))

	return Router
}
