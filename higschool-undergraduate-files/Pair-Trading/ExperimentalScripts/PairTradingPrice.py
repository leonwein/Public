import click, json, time, math
import robin_stocks as rh

@click.group()
def main():
    content = open('config.json').read()
    config = json.loads(content)
    rh.login(config['username'], config['password'])


@main.command(help='backtest')
@click.option('--tick1', prompt = '1st ticker: ')
@click.option('--tick2', prompt = '2nd ticker: ')
def backtest(tick1, tick2):
    historyDict1 = rh.stocks.get_stock_historicals(tick1, interval = 'day', span = 'year', bounds = 'regular', info = None)
    historyDict2 = rh.stocks.get_stock_historicals(tick2, interval = 'day', span = 'year', bounds = 'regular', info = None)
    list1 = []
    list2 = []
    buySellBack = False
    afterBuy = False
    highMargin = .05
    lowMargin = .03
    
    bsFrac = 1
    lastI = 0
    stockFrac = 0
    aDotb = 0
    normA = 0
    normB = 0
    bsCount = 0

    for i, hist in enumerate(historyDict1, start=0):

        list1.append(float(hist['close_price']))
        list2.append(float(historyDict2[i]['close_price']))
        
        #print("{}   |   {}".format(100*(list1[i]-list2[i]), hist['begins_at']))
        # print(lowMargin*list1[i])
        # print(highMargin*list1[i])
        # print(list1[i]-stockFrac*list2[i])
        #print()

        if(hist['begins_at'] == '2020-01-27T00:00:00Z'): #'2020-01-27T00:00:00Z'
            #initial buy

            s1Amount = 1 
            s2Amount = float(hist['close_price'])/float(historyDict2[i]['close_price'])
            afterBuy = True
            s1 = s1Amount*float(hist['close_price'])
            s2 = s2Amount*float(historyDict2[i]['close_price'])
            initialBuy = s1+s2
            invested = s1+s2
            buyPow = 0
            stockFrac = float(hist['close_price'])/float(historyDict2[i]['close_price'])
            
            print("initial buy at: {}".format(initialBuy))
            print("Bought {} shares of {} at the price of: {}".format(s1Amount, tick1, hist['close_price']))
            print("Bought {} shares of {} at the price of: {}".format(s2Amount, tick2, historyDict2[i]['close_price']))
            print("________________")
            lastI = i
            
 
        if(list1[i]-stockFrac*list2[i] > highMargin*list1[i] and buySellBack == False and afterBuy == True):
            #sell from list1 buy from list2 
            list1Sold = True
            buySellBack = True
            s1 = s1Amount*float(hist['close_price'])-bsFrac*s1Amount*float(hist['close_price'])
            s2 = s2Amount*float(historyDict2[i]['close_price'])+bsFrac*s2Amount*float(historyDict2[i]['close_price'])
            invested = s1+s2
            buyPow += bsFrac*s1Amount*float(hist['close_price']) - bsFrac*s2Amount*float(historyDict2[i]['close_price']) 
           
            print(hist['begins_at'])

            print(list1[i]-stockFrac*list2[i])
            print(highMargin*list1[i])
            print("Own {} shares of {} and {} shares of {}".format(s1Amount-bsFrac*s1Amount, tick1, s2Amount+bsFrac*s2Amount,tick2))

            print("BUY & SELL")
            print("Sold {} at the price of: {}".format(tick1, hist['close_price']))
            print("Bought {} at the price of: {}".format(tick2, historyDict2[i]['close_price']))
            print("Invested: {}".format(invested))
            print("Buying Power: {}".format(buyPow))
            print("Total: {}".format(invested+buyPow))
            print("Profit: {}".format(invested+buyPow-initialBuy))
            print("________________")
            lastI = i
            bsCount += 1
        elif(list1[i]-stockFrac*list2[i] <  - highMargin*list1[i] and buySellBack == False and afterBuy == True):
            #buy from list1 sell from list2
            list1Sold = False
            buySellBack = True
            s1 = s1Amount*float(hist['close_price'])+bsFrac*s1Amount*float(hist['close_price'])
            s2 = s2Amount*float(historyDict2[i]['close_price'])-bsFrac*s2Amount*float(historyDict2[i]['close_price'])
            invested = s1+s2
            buyPow += -bsFrac*s1Amount*float(hist['close_price']) + bsFrac*s2Amount*float(historyDict2[i]['close_price'])
            print(hist['begins_at'])

            print(list1[i]-stockFrac*list2[i])
            print(highMargin*list1[i])
            print("Own {} shares of {} and {} shares of {}".format(s1Amount+bsFrac*s1Amount, tick1, s2Amount-bsFrac*s2Amount,tick2))

            print("BUY & SELL")
            print("Bought {} at the price of: {}".format(tick1, hist['close_price']))
            print("Sold {} at the price of: {}".format(tick2, historyDict2[i]['close_price']))
            print("Invested: {}".format(invested))
            print("Buying Power: {}".format(buyPow))
            print("Total: {}".format(invested+buyPow))
            print("Profit: {}".format(invested+buyPow-initialBuy))
            print("________________")
            lastI = i
            bsCount += 1
        elif(abs(list1[i]-stockFrac*list2[i]) <  lowMargin*list1[i] and buySellBack == True and list1Sold == True and afterBuy == True):
            #buy and sell back 
            buySellBack = False
            s1 = s1Amount*float(hist['close_price'])
            s2 = s2Amount*float(historyDict2[i]['close_price'])
            invested = s1+s2
            buyPow += -bsFrac*s1Amount*float(hist['close_price']) + bsFrac*s2Amount*float(historyDict2[i]['close_price'])
            print(hist['begins_at'])

            print(list1[i]-stockFrac*list2[i])
            print(lowMargin*list1[i])
            print("Own {} shares of {} and {} shares of {}".format(s1Amount, tick1, s2Amount,tick2))

            print("BUY & SELL BACK")
            print("Bought {} at the price of: {}".format(tick1, hist['close_price']))
            print("Sold {} at the price of: {}".format(tick2, historyDict2[i]['close_price']))
            print("Invested: {}".format(invested))
            print("Buying Power: {}".format(buyPow))
            print("Total: {}".format(invested+buyPow))
            print("Profit: {}".format(invested+buyPow-initialBuy))
            print("________________")
            lastI = i
            bsCount += 1
        elif(abs(list1[i]-stockFrac*list2[i]) <  lowMargin*list1[i] and buySellBack == True and list1Sold == False and afterBuy == True):
            #buy and sell back 
            buySellBack = False
            s1 = s1Amount*float(hist['close_price'])
            s2 = s2Amount*float(historyDict2[i]['close_price'])
            invested = s1+s2
            buyPow += bsFrac*s1Amount*float(hist['close_price']) - bsFrac*s2Amount*float(historyDict2[i]['close_price']) 
            print(hist['begins_at'])

            print(list1[i]-stockFrac*list2[i])
            print(lowMargin*list1[i])
            print("Own {} shares of {} and {} shares of {}".format(s1Amount, tick1, s2Amount,tick2))

            print("BUY & SELL BACK")
            print("Sold {} at the price of: {}".format(tick1, hist['close_price']))
            print("Bought {} at the price of: {}".format(tick2, historyDict2[i]['close_price']))
            print("Invested: {}".format(invested))
            print("Buying Power: {}".format(buyPow))
            print("Total: {}".format(invested+buyPow))
            print("Profit: {}".format(invested+buyPow-initialBuy))
            print("________________")
            lastI = i
            bsCount += 1
        # print(s1Amount*float(historyDict1[i]['close_price']))
        # print(s2Amount*float(historyDict2[i]['close_price']))
        # print(s1Amount*float(historyDict1[i]['close_price'])+s2Amount*float(historyDict2[i]['close_price']))
        # print()

    print("total profit w/algorithm: {}".format(invested+buyPow-initialBuy))
    print("annual growth w/algorithm: +%{}".format(100*(invested+buyPow-initialBuy)/initialBuy))
    print("------------------")
    print("total profit w/o algorithm: {}".format(s1Amount*float(historyDict1[lastI]['close_price']) + s2Amount*float(historyDict2[lastI]['close_price']) - initialBuy))
    print("annual growth w/o algorithm: +%{}".format(100*(s1Amount*float(historyDict1[lastI]['close_price']) + s2Amount*float(historyDict2[lastI]['close_price'])-initialBuy)/initialBuy))
    print()

    print("{}({})".format(tick1,s1Amount))
    print("{}({})".format(tick2,s2Amount))
    print(invested+buyPow-initialBuy)
    print(100*(invested+buyPow-initialBuy)/initialBuy)
    print(s1Amount*float(historyDict1[lastI]['close_price']) + s2Amount*float(historyDict2[lastI]['close_price']) - initialBuy)
    print(100*(s1Amount*float(historyDict1[lastI]['close_price']) + s2Amount*float(historyDict2[lastI]['close_price'])-initialBuy)/initialBuy)
    

    for i, hist in enumerate(historyDict1, start=0):

        list1.append(float(hist['close_price']))
        list2.append(float(historyDict2[i]['close_price']))
        aDotb += list1[i]*list2[i]
        normA += list1[i] ** 2
        normB += list2[i] ** 2

    
    #print("A dot B: {}, norm A: {}, norm B: {}".format(aDotb, normA, normB))

    #print("the similarity correlation is: {}".format(aDotb/(math.sqrt(normA * normB))))
    print(aDotb/(math.sqrt(normA * normB)))
    print(bsCount)

    
    



    
@main.command(help='similarity')
@click.option('--tick1', prompt = '1st ticker: ')
@click.option('--tick2', prompt = '2nd ticker: ')
def similarity(tick1, tick2):
    historyDict1 = rh.stocks.get_stock_historicals(tick1, interval = 'day', span = 'year', bounds = 'regular', info = None)
    historyDict2 = rh.stocks.get_stock_historicals(tick2, interval = 'day', span = 'year', bounds = 'regular', info = None)
    list1 = []
    list2 = []
    aDotb = 0
    normA = 0
    normB = 0

    for i, hist in enumerate(historyDict1, start=0):

        list1.append(float(hist['close_price']))
        list2.append(float(historyDict2[i]['close_price']))
        aDotb += list1[i]*list2[i]
        normA += list1[i] ** 2
        normB += list2[i] ** 2

    
    print("A dot B: {}, norm A: {}, norm B: {}".format(aDotb, normA, normB))

    print("the similarity correlation is: {}".format(aDotb/(math.sqrt(normA * normB))))


    


if __name__ == '__main__':
    main()