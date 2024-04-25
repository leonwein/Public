import click, json, time
import robin_stocks as rh




#@click.group()
def main():
    print("main")
    sharePrices = []
    buyList = []
    soldList = []
    content = open('config.json').read()
    config = json.loads(content)
    rh.login(config['username'], config['password']) 
    getSharePrices(sharePrices, buyList)
    #buy stocks here
    #runLoop(sharePrices, buyList, soldList)
    historyDict = rh.stocks.get_stock_historicals('JPM', interval = '10minute', span = 'week', bounds = 'regular', info = None)

    #print(historyDict)

    #for quote in quotes:#print("{} | {}".format(quote['symbol'], quote['ask_price']))

    for hist in historyDict:
        #print("{}".format(float(hist['open_price'])))
        print("open price is {}, and close price is {}, with a percentage change of {}".format(float(hist['open_price']), float(hist['close_price']), 100*(float(hist['close_price']) - float(hist['open_price']))/ float(hist['open_price'])))
        #print("{}".format(100*(float(hist['close_price']) - float(hist['open_price']))/ float(hist['open_price'])))



    

def getSharePrices(sharePrices, buyList):
    print("Getting quotes for buylist")
    with open('buylist') as w:

        symbols = w.read().splitlines()
        latestPrices = rh.get_latest_price(symbols)
        for i, price in enumerate(latestPrices, start = 0):
            print("{} | {}".format(symbols[i], float(latestPrices[i])))
            sharePrices.append(float(latestPrices[i]))
            buyList.append(symbols[i])

        #print(sharePrices)

def runLoop(sharePrices, buyList, soldList):
    
    profitsList = []
            
    while True:

        with open('buylist') as w:

            symbols = w.read().splitlines()
            latestPrices = rh.get_latest_price(symbols)

        for i, price in enumerate(latestPrices, start=0):

            if(float(latestPrices[i]) <= (sharePrices[i])*(1-.005) and symbols[i] in buyList):
                print("sell {} at {}".format(symbols[i], float(latestPrices[i])))
                print("loss of ${} - ${} = ${}".format(float(latestPrices[i]), sharePrices[i], float(latestPrices[i])-sharePrices[i]))
                profitsList.append(float(latestPrices[i])-sharePrices[i])
                 #sell

                soldList.append(symbols[i])
                buyList.remove(symbols[i])
                if not buyList:
                    break
               
            elif(float(latestPrices[i]) >= (sharePrices[i])*(1+.0025) and symbols[i] in buyList):
                print("sell {} at {}".format(symbols[i], float(latestPrices[i])))
                print("profit of ${} - ${} = ${}".format(float(latestPrices[i]), sharePrices[i], float(latestPrices[i])-sharePrices[i]))
                profitsList.append(float(latestPrices[i])-sharePrices[i])
                 #sell

                soldList.append(symbols[i])
                buyList.remove(symbols[i])
                if not buyList:
                    break
            else:
                print(symbols[i])
                if symbols[i] in soldList:
                    print("(SOLD)")
                else:
                    print(float(latestPrices[i]))
                    print((sharePrices[i])*(1-.005))
                    print((sharePrices[i])*(1+.0025))
                    print("dont sell")
                print("-------------")

        if not buyList:
            break
                
        print("_____________________________________________________________-")
        
        time.sleep(5)

    for profit in profitsList:
        total += profit
    
    print(total)

if __name__ == '__main__':
    main()