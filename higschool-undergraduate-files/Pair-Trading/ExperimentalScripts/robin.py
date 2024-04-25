import click, json, math
import robin_stocks as rh

@click.group()
def main():
    print("main")
    content = open('config.json').read()
    config = json.loads(content)
    rh.login(config['username'], config['password'])

@main.command(help='gets a stock quote for one or more symbols')
@click.argument('symbols', nargs =- 1)
def quote(symbols):
    

    quotes = rh.get_quotes(symbols)
    
    for quote in quotes:
        print("{} | {}".format(quote['symbol'], quote['ask_price']))
    #print(symbols)
    #for symbol in symbols:
        #print("Getting a stock quote for symbol {}".format(symbol))

@main.command(help='Gets quotes for all stocks in your watchlist')
def watchlist():
    print("Getting quotes for watchist")
    with open('watchlist') as w:
       

        symbols = w.read().splitlines()
        quotes = rh.get_quotes(symbols)

        for quote in quotes:
            print("{} | {}".format(quote['symbol'], quote['ask_price']))


@main.command(help='buy stock with given ticker')
@click.argument('ticker', type=click.STRING)
@click.argument('quantity', type=click.FLOAT)
@click.option('--limit', type=click.FLOAT)
def buy(ticker, quantity, limit):

    if limit is not None:
        click.echo(click.style("Buying {} share/s of {} at {}".format(quantity,ticker,limit), fg="green", bold=True))
        result = rh.order_buy_limit(ticker,quantity,limit)

    else:
        click.echo(click.style("Buying {} share/s of {}".format(quantity,ticker), fg="green", bold=True))
        result = rh.orders.order_buy_fractional_by_quantity(ticker, quantity)

    click.echo(click.style(str(result), fg = "green", bold = True))
    
@main.command(help='sell stock with given ticker')
@click.argument('ticker', type=click.STRING)
@click.argument('quantity', type=click.FLOAT)
@click.option('--limit', type=click.FLOAT)
def sell(ticker, quantity, limit):

    if limit is not None:
        click.echo(click.style("Buying {} share/s of {} at {}".format(quantity,ticker,limit), fg="green", bold=True))
        result = rh.order_sell_limit(ticker,quantity,limit)

    else:
        click.echo(click.style("Buying {} share/s of {}".format(quantity,ticker), fg="green", bold=True))
        result = rh.orders.order_sell_fractional_by_quantity(ticker, quantity)

    if 'ref_id' in result:
        click.echo(click.style(str(result), fg = "green", bold = True))
    else:
        click.echo(click.style(str(result), fg = "red", bold = True))


@main.command(help='get stock history')
@click.option('--ticker', prompt='ticker: ')
@click.option('--interval', prompt='interval: ') # ‘5minute’, ‘10minute’, ‘hour’, ‘day’, ‘week’. Default is ‘hour’.
@click.option('--span', prompt='span: ') # ‘day’, ‘week’, ‘month’, ‘3month’, ‘year’, or ‘5year’. Default is ‘week’.
@click.option('--bounds', prompt='bounds: ') #‘extended’, ‘trading’, or ‘regular’
def history(ticker, interval, span, bounds):
    historyDict = rh.stocks.get_stock_historicals(ticker, interval = interval, span = span, bounds = bounds, info = None)



@main.command(help='get similarity correlation')
@click.option('--tick1', prompt = '1st ticker: ')
@click.option('--tick2', prompt = '2nd ticker: ')
@click.option('--indicator', prompt = 'indicator: ') # 'open_price', 'close_price', 'high_price', 'low_price', 'volume', 'pc'
def similarity(tick1, tick2, indicator):
    historyDict1 = rh.stocks.get_stock_historicals(tick1, interval = 'week', span = 'year', bounds = 'regular', info = None)
    historyDict2 = rh.stocks.get_stock_historicals(tick2, interval = 'week', span = 'year', bounds = 'regular', info = None)
    list1 = []
    list2 = []
    aDotb = 0
    normA = 0
    normB = 0
    buySellBack = False
    afterBuy = False
    highMargin = 2
    lowMargin = .5
    s1Amount = 1
    s2Amount = 1
    bsFrac = 1

    for i, hist in enumerate(historyDict1, start=0):
        if(indicator == 'pc'):
            list1.append((float(hist['close_price']) - float(hist['open_price']))/float(hist['open_price']))
            list2.append((float(historyDict2[i]['close_price']) - float(historyDict2[i]['open_price']))/float(historyDict2[i]['open_price']))
        else:
            list1.append(float(hist[indicator]))
            list2.append(float(historyDict2[i][indicator]))

        #print("{}   |   {}".format(100*(list1[i]-list2[i]), hist['begins_at']))
        
        

        if(hist['begins_at'] == '2020-04-27T00:00:00Z'):
            #initial buy
            afterBuy = True
            s1 = s1Amount*float(hist['open_price'])
            s2 = s2Amount*float(historyDict2[i]['open_price'])
            initialBuy = s1+s2
            invested = s1+s2
            buyPow = 0
            
            print("initial buy at: {}".format(initialBuy))
            print("Bought {} shares of {} at the price of: {}".format(s1Amount, tick1, hist['open_price']))
            print("Bought {} shares of {} at the price of: {}".format(s2Amount, tick2, historyDict2[i]['open_price']))
            print("________________")
 
        if(100*(list1[i]-list2[i]) > highMargin and buySellBack == False and afterBuy == True):
            #sell from list1 buy from list2 
            list1Sold = True
            buySellBack = True
            s1 = s1Amount*float(hist['open_price'])-bsFrac*s1Amount*float(hist['open_price'])
            s2 = s2Amount*float(historyDict2[i]['open_price'])+bsFrac*s2Amount*float(historyDict2[i]['open_price'])
            invested = s1+s2
            buyPow += bsFrac*s1Amount*float(hist['open_price']) - bsFrac*s2Amount*float(historyDict2[i]['open_price']) 
            # print(hist['begins_at'])
            # print(100*(list1[i]-list2[i]))
            # print("BUY & SELL")
            # print("Sold {} at the price of: {}".format(tick1, hist['open_price']))
            # print("Bought {} at the price of: {}".format(tick2, historyDict2[i]['open_price']))
            # print("Invested: {}".format(invested))
            # print("Buying Power: {}".format(buyPow))
            # print("Total: {}".format(invested+buyPow))
            # print("Profit: {}".format(invested+buyPow-initialBuy))
            # print("________________")
        elif(100*(list1[i]-list2[i]) < -highMargin and buySellBack == False and afterBuy == True):
            #buy from list1 sell from list2
            list1Sold = False
            buySellBack = True
            s1 = s1Amount*float(hist['open_price'])+bsFrac*s1Amount*float(hist['open_price'])
            s2 = s2Amount*float(historyDict2[i]['open_price'])-bsFrac*s2Amount*float(historyDict2[i]['open_price'])
            invested = s1+s2
            buyPow += -bsFrac*s1Amount*float(hist['open_price']) + bsFrac*s2Amount*float(historyDict2[i]['open_price'])
            # print(hist['begins_at'])
            # print(100*(list1[i]-list2[i]))
            # print("BUY & SELL")
            # print("Bought {} at the price of: {}".format(tick1, hist['open_price']))
            # print("Sold {} at the price of: {}".format(tick2, historyDict2[i]['open_price']))
            # print("Invested: {}".format(invested))
            # print("Buying Power: {}".format(buyPow))
            # print("Total: {}".format(invested+buyPow))
            # print("Profit: {}".format(invested+buyPow-initialBuy))
            # print("________________")
        elif(abs(100*(list1[i]-list2[i])) < lowMargin and buySellBack == True and list1Sold == True and afterBuy == True):
            #buy and sell back 
            buySellBack = False
            s1 = s1Amount*float(hist['open_price'])
            s2 = s2Amount*float(historyDict2[i]['open_price'])
            invested = s1+s2
            buyPow += -bsFrac*s1Amount*float(hist['open_price']) + bsFrac*s2Amount*float(historyDict2[i]['open_price'])
            # print(hist['begins_at'])
            # print(100*(list1[i]-list2[i]))
            # print("BUY & SELL BACK")
            # print("Bought {} at the price of: {}".format(tick1, hist['open_price']))
            # print("Sold {} at the price of: {}".format(tick2, historyDict2[i]['open_price']))
            # print("Invested: {}".format(invested))
            # print("Buying Power: {}".format(buyPow))
            # print("Total: {}".format(invested+buyPow))
            # print("Profit: {}".format(invested+buyPow-initialBuy))
            # print("________________")
        elif(abs(100*(list1[i]-list2[i])) < lowMargin and buySellBack == True and list1Sold == False and afterBuy == True):
            #buy and sell back 
            buySellBack = False
            s1 = s1Amount*float(hist['open_price'])
            s2 = s2Amount*float(historyDict2[i]['open_price'])
            invested = s1+s2
            buyPow += bsFrac*s1Amount*float(hist['open_price']) - bsFrac*s2Amount*float(historyDict2[i]['open_price']) 
            # print(hist['begins_at'])
            # print(100*(list1[i]-list2[i]))
            # print("BUY & SELL BACK")
            # print("Sold {} at the price of: {}".format(tick1, hist['open_price']))
            # print("Bought {} at the price of: {}".format(tick2, historyDict2[i]['open_price']))
            # print("Invested: {}".format(invested))
            # print("Buying Power: {}".format(buyPow))
            # print("Total: {}".format(invested+buyPow))
            # print("Profit: {}".format(invested+buyPow-initialBuy))
            # print("________________")

    print("total profit: {}".format(invested+buyPow-initialBuy))
    print("annual growth: +%{}".format(100*(invested+buyPow-initialBuy)/initialBuy))
    


    for i, ind in enumerate(list1, start=0):
        aDotb += list1[i]*list2[i]
        normA += list1[i] ** 2
        normB += list2[i] ** 2

    print("A dot B: {}, norm A: {}, norm B: {}".format(aDotb, normA, normB))

    print("the similarity correlation is: {}".format(aDotb/(math.sqrt(normA * normB))))






if __name__ == '__main__':
    main()