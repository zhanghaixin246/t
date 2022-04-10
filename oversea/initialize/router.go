package initialize

import "github.com/gin-gonic/gin"

func Routers() *gin.Engine {
	Router := gin.Default()

	PublicGroup := Router.Group("")
	{
		PublicGroup.GET("/", func(c *gin.Context) {
			c.JSON(200, "oversea")
		})
	}

	return Router
}
