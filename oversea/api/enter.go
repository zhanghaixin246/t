package api

import "t/oversea/service"

type Group struct {
	BaseApi
}

var GroupApp = new(Group)

var (
	baseService = service.ServiceGroupApp.BaseService
)
