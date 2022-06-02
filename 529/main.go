package main

import (
	"log"
	"os"
	"sync"
)

func main() {

	// 创建、追加、读写，777，所有权限
	f, err := os.OpenFile("log.log", os.O_CREATE|os.O_APPEND|os.O_RDWR, os.ModePerm)
	if err != nil {
		return
	}
	defer func() {
		f.Close()
	}()

	log.SetOutput(f)

	wg := sync.WaitGroup{}
	for i := 1; i < 100; i++ {
		wg.Add(1)
		go func(i interface{}) {
			defer wg.Done()
			test(i)
		}(i)
	}
	wg.Wait()
	println("end")

}

func test(i interface{}) {
	log.Println(i)
}
