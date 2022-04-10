package service

import "fmt"

type BaseService struct {
}

func (b *BaseService) RecordCaptcha(phone string) error {
	fmt.Println(phone)
	return nil
}
