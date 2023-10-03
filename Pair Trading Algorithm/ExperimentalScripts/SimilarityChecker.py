import click, json, time, math
import robin_stocks as rh


def main():
    content = open('config.json').read()
    config = json.loads(content)
    rh.login(config['username'], config['password'])
    list1 = []
    list2 = []


    with open('Stocks') as w:

        symbols = w.read().splitlines()
        
        for i in range(0,len(symbols)-2):
            for j in range(i+1,len(symbols)-1):
                simCo = similarity(symbols[i], symbols[j])
                print(symbols[i], symbols[j], simCo)
                if simCo >= .997:
                   list1.append("{} {} {}".format(symbols[i], symbols[j], simCo))
                   #print(symbols[j], symbols[j], simCo)
                   print()


    print(list1)

            




def similarity(tick1, tick2):
   
    historyDict1 = rh.stocks.get_stock_historicals(tick1, interval = 'week', span = '5year', bounds = 'regular', info = None)
    historyDict2 = rh.stocks.get_stock_historicals(tick2, interval = 'week', span = '5year', bounds = 'regular', info = None)
    
       
    initPrice1 = historyDict1[0]['close_price']
    initPrice2 = historyDict2[0]['close_price']
    list1 = []
    list2 = []
    aDotb = 0
    normA = 0
    normB = 0
    if(initPrice1 == None  or initPrice2 == None or float(initPrice1) == 0 or float(initPrice2) == 0):
        return 0
    
    for i, hist in enumerate(historyDict1, start=0):

        # list1.append((float(hist['close_price'])-float(initPrice1))/float(initPrice1))
        # list2.append((float(historyDict2[i]['close_price'])-float(initPrice2))/float(initPrice2))

        list1.append(float(hist['close_price']))
        list2.append(float(historyDict2[i]['close_price']))
        aDotb += list1[i]*list2[i]
        normA += list1[i] ** 2
        normB += list2[i] ** 2

    
   
    # print(tick1)
    # print(tick2)
    # print(aDotb/(math.sqrt(normA * normB)))
    # print()
    
    if(normA*normB == 0):
        return 0

    return(aDotb/(math.sqrt(normA * normB)))


if __name__ == '__main__':
    main()