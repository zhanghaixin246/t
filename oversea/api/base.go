package api

import (
	"github.com/gin-gonic/gin"
	"strconv"
	"t/oversea/model/common/response"
	"t/oversea/model/request"
)

type BaseApi struct {
}

func (b *BaseApi) Captcha(c *gin.Context) {
	var r request.GetCaptcha
	err := c.ShouldBindJSON(&r)
	if err != nil {
		response.Fail(c)
		return
	}
	//
	err = baseService.RecordCaptcha(r.Phone)
	if err != nil {

	}
	num, _ := strconv.Atoi(r.Phone)
	numStr := strconv.Itoa(num + 1)
	captcha := numStr[len(numStr)-6:]

	response.OkWithData(captcha, c)

}
