package main

import (
	"io"
	"io/ioutil"
	"log"
	"net/http"
	"os"
	"regexp"
	"strconv"
	"strings"
	"sync"
)

// "<meta name=\"description\" content=\"热门推荐:超漂亮护士小少妇,度过了舒服畅快的晚霞-医生护士-拔插拔插（8x8x）\">"
const reH1 = `<meta name="description" content(.*)>`

func GetH1(url string) (res string) {
	resp, err := http.Get(url)
	if err != nil {
		log.Fatal("http.Get error :", err)
	}
	defer func(Body io.ReadCloser) {
		err := Body.Close()
		if err != nil {
			log.Fatal("close error :", err)
		}
	}(resp.Body)
	dataBytes, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		log.Fatal("ReadAll error :", err)
	}
	str := string(dataBytes)
	re := regexp.MustCompile(reH1)
	results := re.FindAllStringSubmatch(str, -1)
	//println(url)
	//fmt.Printf("%#v", results)
	for _, result := range results {
		//fmt.Println("===============")
		if strings.ContainsRune(result[0], '公') && strings.ContainsRune(result[0], '司') {
			//fmt.Printf("%#v", result[0])
			//fmt.Println()
			log.Println(result[0] + "=>")
			log.Println(url)
			//res += result[2]
		}
		//log.Println(result[0] + "=>" + url)
	}
	//os.Exit(1)
	return
}
func main() {
	// 创建、追加、读写，777，所有权限
	f, err := os.OpenFile("log1.log", os.O_CREATE|os.O_APPEND|os.O_RDWR, os.ModePerm)
	if err != nil {
		return
	}
	defer func() {
		f.Close()
	}()

	log.SetOutput(f)

	//log.SetFlags(log.Lshortfile | log.LstdFlags)
	url := "https://"
	//res := ""
	wg := sync.WaitGroup{}
	ch := make(chan struct{}, 80)
	for i := 66954; i > 11111; i-- {
		wg.Add(1)
		ch <- struct{}{}
		go func(i int) {
			println(i)
			defer wg.Done()
			//log.Println(i)
			GetH1(url + strconv.Itoa(i))
			<-ch
		}(i)
	}
	//log.Println(res)
	wg.Wait()
	println("end")
}
