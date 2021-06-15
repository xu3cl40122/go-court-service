import { Test, } from '@nestjs/testing';
import { TicketsController } from './tickets.controller';
import { TicketsService } from './tickets.service';
import { getRepositoryToken } from '@nestjs/typeorm';
import { Game } from '../../entity/game.entity';
import { GameUser } from '../../entity/game_user.entity';
import { GameTicket } from '../../entity/game_ticket.entity';
import { GameStock } from '../../entity/game_stock.entity';
import { User } from '../../entity/user.entity';
import { Verification } from '../../entity/verification.entity';
import { GamesService } from '../games/games.service'
import { UsersService } from '../users/users.service'
import { MessageService } from '../message/message.service'
import { CreateGameDto, UpdateGameDto } from '../../dto/game.dto'
import { HttpException, HttpStatus } from '@nestjs/common'


describe('TicketsController', () => {
  let ticketsController: TicketsController;
  let ticketsService: TicketsService;
  let gamesService: GamesService;
  let usersService: UsersService;
  let req = { payload: { user_id: 'test_user_id' } }
  let gameTicket: GameTicket
  let mockGame = new Game()
  let carts = [
    {
      "stock_amount": 1,
      "game_stock_id": "7e72e5e5-17be-4efd-92dd-db6481ebe400"
    }
  ]

  beforeEach(async () => {
    const moduleRef = await Test.createTestingModule({
      // 要把要用到 Repository import 進來
      imports: [],
      providers: [
        GamesService,
        TicketsService,
        UsersService,

        // mock 的部分
        {
          provide: MessageService,
          useValue: {}
        },
        {
          provide: getRepositoryToken(Game),
          useValue: {}
        },
        {
          provide: getRepositoryToken(GameUser),
          useValue: {}
        },
        {
          provide: getRepositoryToken(GameTicket),
          useValue: {}
        },
        {
          provide: getRepositoryToken(GameStock),
          useValue: {}
        },
        {
          provide: getRepositoryToken(User),
          useValue: {}
        },
        {
          provide: getRepositoryToken(Verification),
          useValue: {}
        },
      ],
      controllers: [TicketsController],
    }).compile();

    ticketsService = moduleRef.get<TicketsService>(TicketsService);
    usersService = moduleRef.get<UsersService>(UsersService);
    gamesService = moduleRef.get<GamesService>(GamesService);
    ticketsController = moduleRef.get<TicketsController>(TicketsController);
    req = { payload: { user_id: 'test_user_id' } }
    carts = [
      {
        "stock_amount": 1,
        "game_stock_id": "7e72e5e5-17be-4efd-92dd-db6481ebe400"
      }
    ]
    gameTicket = new GameTicket({
      game_id: 'game_id',
      game_stock_id: 'game_stock_id',
      owner_user_id: 'owner_user_id',
      game_ticket_status: 'PENDING'
    })

    mockGame = new Game()
    mockGame.game_id = 'game_id'
    mockGame.host_user_id = 'host_user_id'
    mockGame.game_status = 'PENDING'
  });

  describe('Checkout ticket', () => {
    it('should throw error if carts is empty', async () => {
      carts = []
      await expect(ticketsController.checkout(req, carts))
        .rejects.toEqual(new HttpException('request body should be array of target spec', HttpStatus.BAD_REQUEST))
    });

    it('should throw error if target game status is not PENDING', async () => {
      let mockGameStock = new GameStock()
      mockGameStock.game_detail = {
        game_status: 'PLAYING'
      }
      jest.spyOn(ticketsService, 'findGameStock').mockImplementation(async () => mockGameStock);
      await expect(ticketsController.checkout(req, carts))
        .rejects.toEqual(new HttpException('some game is not available', HttpStatus.BAD_REQUEST))
    });

    it('should throw error if target game is not selling', async () => {
      let mockGameStock = new GameStock()
      mockGameStock.game_detail = {
        game_status: 'PENDING',
        sell_start_at: new Date(new Date().getTime() + 1000)
      }
      jest.spyOn(ticketsService, 'findGameStock').mockImplementation(async () => mockGameStock);
      await expect(ticketsController.checkout(req, carts))
        .rejects.toEqual(new HttpException('some game is not available', HttpStatus.BAD_REQUEST))
    });

    it('should throw error if ticket sold out', async () => {
      let mockGameStock = new GameStock()
      mockGameStock.game_detail = {
        game_status: 'PENDING',
        sell_start_at: new Date(new Date().getTime() - 1000),
        sell_end_at: new Date(new Date().getTime() + 1000)
      }
      jest.spyOn(ticketsService, 'findGameStock').mockImplementation(async () => mockGameStock);
      jest.spyOn(ticketsService, 'checkout').mockImplementation(async () => {
        throw { code: '23514' }
      });
      await expect(() => ticketsController.checkout(req, carts))
        .rejects.toEqual(new HttpException('tickets sold out', HttpStatus.BAD_REQUEST))
    });

    it('should checkout success', async () => {
      let mockGameStock = new GameStock()
      mockGameStock.game_detail = {
        game_status: 'PENDING',
        sell_start_at: new Date(new Date().getTime() - 1000),
        sell_end_at: new Date(new Date().getTime() + 1000)
      }
      let tickets = [gameTicket]
      jest.spyOn(ticketsService, 'findGameStock').mockImplementation(async () => mockGameStock);
      jest.spyOn(ticketsService, 'checkout').mockImplementation(async () => tickets)
      expect(await ticketsController.checkout(req, carts)).toEqual({ tickets })
    });

  });

  describe('Transfer ticket', () => {
    let body = {
      "receiver_id": "32ff8ab8-69de-4479-8a3d-956f6f208fef"
    }
    it('should throw error if ticket not found', async () => {
      jest.spyOn(ticketsService, 'findGameTicket').mockImplementation(async () => null);
      jest.spyOn(usersService, 'findUser').mockImplementation(async () => null)
      await expect(ticketsController.transferTicket(req, 'ticket_id', body))
        .rejects.toEqual(new HttpException('ticket not found', HttpStatus.BAD_REQUEST))
    })

    it('should throw error if user not found', async () => {
      jest.spyOn(ticketsService, 'findGameTicket').mockImplementation(async () => gameTicket)
      jest.spyOn(usersService, 'findUser').mockImplementation(async () => null)

      await expect(ticketsController.transferTicket(req, 'ticket_id', body))
        .rejects.toEqual(new HttpException('receiver not found', HttpStatus.BAD_REQUEST))
    })

    it('should throw error if requester is not ticket owner', async () => {
      jest.spyOn(ticketsService, 'findGameTicket').mockImplementation(async () => gameTicket)
      jest.spyOn(usersService, 'findUser').mockImplementation(async () => new User())

      await expect(ticketsController.transferTicket(req, 'ticket_id', body))
        .rejects.toEqual(new HttpException('only owner of ticket can access', HttpStatus.FORBIDDEN))
    })

    it('should throw error if target ticekt game status is not PENDING', async () => {
      gameTicket.game_ticket_status = 'PLAYING'
      gameTicket.owner_user_id = req.payload.user_id
      let user = new User()
      user.user_id = req.payload.user_id
      jest.spyOn(ticketsService, 'findGameTicket').mockImplementation(async () => gameTicket)
      jest.spyOn(usersService, 'findUser').mockImplementation(async () => user)

      await expect(ticketsController.transferTicket(req, 'ticket_id', body))
        .rejects.toEqual(new HttpException("can't transfer ticket which ticket status isn't PENDING", HttpStatus.FORBIDDEN))
    })

    it('should trsnsfer ticket success', async () => {
      gameTicket.owner_user_id = req.payload.user_id
      let tsTicket = new GameTicket({
        game_id: 'game_id',
        game_stock_id: 'game_stock_id',
        owner_user_id: 'receiver_user_id'
      })
      let user = new User()
      user.user_id = req.payload.user_id
      jest.spyOn(ticketsService, 'findGameTicket').mockImplementation(async () => gameTicket)
      jest.spyOn(usersService, 'findUser').mockImplementation(async () => user)
      jest.spyOn(ticketsService, 'transferTicket').mockImplementation(async () => tsTicket)

      expect(await ticketsController.transferTicket(req, 'ticket_id', body)).toEqual(tsTicket)
    })

  })

  describe('Verify Ticket', () => {
    it('should throw error if game not found', async () => {
      jest.spyOn(ticketsService, 'findGameTicket').mockImplementation(async () => gameTicket)
      jest.spyOn(gamesService, 'findGame').mockImplementation(async () => null)
      await expect(ticketsController.verifyTicket(req, mockGame.game_id, gameTicket.game_ticket_id))
        .rejects.toEqual(new HttpException("wrong game_id", HttpStatus.BAD_REQUEST))
    })

    it('should throw error if request user_id in not game host_user_id', async () => {
      jest.spyOn(ticketsService, 'findGameTicket').mockImplementation(async () => gameTicket)
      jest.spyOn(gamesService, 'findGame').mockImplementation(async () => mockGame)
      await expect(ticketsController.verifyTicket(req, mockGame.game_id, gameTicket.game_ticket_id))
        .rejects.toEqual(new HttpException("only host user can verify ticket", HttpStatus.BAD_REQUEST))
    })

    it('should throw error if game_id not equal', async () => {
      mockGame.game_id = 'verify_game_id'
      mockGame.host_user_id = req.payload.user_id
      jest.spyOn(ticketsService, 'findGameTicket').mockImplementation(async () => gameTicket)
      jest.spyOn(gamesService, 'findGame').mockImplementation(async () => mockGame)
      await expect(ticketsController.verifyTicket(req, mockGame.game_id, gameTicket.game_ticket_id))
        .rejects.toEqual(new HttpException("wrong ticket", HttpStatus.BAD_REQUEST))
    })

    it('should verify success', async () => {
      gameTicket.game_id = 'verify_game_id'
      mockGame.game_id = 'verify_game_id'
      mockGame.host_user_id = req.payload.user_id
      let gameUser = new GameUser({
        game_id: gameTicket.game_id,
        game_stock_id: gameTicket.game_stock_id,
        game_ticket_id: gameTicket.game_ticket_id,
        game_user_id: req.payload.user_id
      })
      jest.spyOn(ticketsService, 'findGameTicket').mockImplementation(async () => gameTicket)
      jest.spyOn(gamesService, 'findGame').mockImplementation(async () => mockGame)
      jest.spyOn(ticketsService, 'verifyTicket').mockImplementation(async () => gameUser)
      await expect(await ticketsController.verifyTicket(req, mockGame.game_id, gameTicket.game_ticket_id))
        .toEqual(gameUser)

    })

  })

});