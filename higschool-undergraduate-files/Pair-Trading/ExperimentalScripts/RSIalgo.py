def main():

    content = open('config.json').read()
    config = json.loads(content)
    rh.login(config['username'], config['password'])
    
    stockString = ""
    tickPrices = []


   
    startDate = "2020-01-25"
    endDate = "2021-01-25"


    with open('Stocks') as w:

        symbols = w.read().splitlines()
        
        for i in range(0,len(symbols)):
            stockString += symbols[i] + " "

        data = yf.download(stockString, start = startDate, end = endDate)

        csvList = []
        
        print("Working on it chief!")

        
        
        for i in range(0,len(symbols)):
            tickPrices = data['Close'][symbols[i]]
            


def backtest(priceList, RSI, rsiPeriod):

    highMargin = .7
    lowMargin = .3
    didBuy = False
    shares = 1


    for i in range(0, len(RSI)):

        if(RSI[i] > highMargin and didBuy == False):
            didBuy == True 
            


        elif(RSI[i] < lowMargin and didBuy == True):
            didBuy == False


       



if __name__ == "__main__":
    main()