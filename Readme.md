# GO COURT 球場資源分享平臺
* [demo](https://tom-lee.site/) 部屬於 AWS EC2。
* 後端用 NestJs 搭配 PostgreSQL 實作 RESTful API ([API 規格](spec.yaml))。
* [前端專案](https://github.com/xu3cl40122/go-court-vue)用 Vue3 開發(目前僅開發手機版畫面)。
* 操作上遇到任何奇怪的地方歡迎發 issue 回報，感謝。

## Demo 影片
* [報名球賽](https://streamable.com/jfsw21)
* [驗票入場](https://streamable.com/7wnm3n)
* [球場地圖](https://streamable.com/zczx85)

## 功能簡介
### 球場地圖
* 透過[全國場館資訊網](https://iplay.sa.gov.tw/WebAPI)提供之 API 取得全臺球場資訊，經過簡單的資料整理後，開放縣市區及球場名稱等參數供前端查詢。
* 前端使用 Google Map Api 進行資料視覺化。

### 球賽管理
* 球賽建立者可設定球賽時間地點、售價及數量、是否公開等。
* 使用者可透過球賽起訖時間、球賽類型、縣市區、球賽名稱等參數搜尋想參加的球賽。
* 票券轉送功能。
* 入場時透過 QRcode 驗證票券。
* Redis 紀錄近期熱門球賽。
* 排程定時關閉應關閉之球賽(已超過預定結束時間)。
* 目前不處理金流部分。

### 使用者管理
* Passport.js、JWT 實作登入驗證。
* Facebook 第三方登入。
* 使用 AWS SES 發送驗證信。

### 檔案管理
* 使用 AWS S3 建立檔案 CRUD API。

### 評論管理
* [評論管理](https://github.com/xu3cl40122/comment-service)設計成獨立的服務，用 NestJs 配上 MongoDB 開發，呼叫時需帶上 token，以管理操作評論之權限。
* 目前用於對球場進行評價。



