import * as serve from 'koa-static'
import { join } from 'path'
import 'reflect-metadata'
import { createKoaServer, useContainer } from 'routing-controllers'
import { Container } from 'typedi'

useContainer(Container)

const koa = createKoaServer({
  routePrefix: '/api/v1',
  controllers: [join(__dirname, 'controllers', '*.ts')]
})

koa.use(serve('.'))
koa.listen(3000)
