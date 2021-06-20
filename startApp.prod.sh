# 不知為何 migration db 的 code 無法順利一起執行
# 但是分開手動呼叫又可以 
npx typeorm migration:generate -n mg -o
npx typeorm migration:run
npm run start:prod