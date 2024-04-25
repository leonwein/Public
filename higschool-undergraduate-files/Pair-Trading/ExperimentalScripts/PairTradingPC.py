import click, json, time, math
import robin_stocks as rh
from scipy.stats import spearmanr
import yfinance as yf

@click.group()
def main():
    content = open('config.json').read()
    config = json.loads(content)
    rh.login(config['username'], config['password'])
    
    



@main.command(help='backtest')
@click.option('--tick1', prompt = '1st ticker: ')
@click.option('--tick2', prompt = '2nd ticker: ')
def backtest(tick1, tick2):
    stockString = tick1 + " " + tick2
    
    data = yf.download(stockString, start = "2020-01-27", end = "2021-01-27")

    list1 = []
    list2 = []
    t1p = data['Close'][tick1]
    t2p = data['Close'][tick2]
    sim = similarity(tick1,tick2)

    
    buySellBack = False
    highMargin = .25-((sim+1)/2.55)**(5.8)
    if.23-((sim+1)/2.55)**(5.8) > 0:
        lowMargin = .23-((sim+1)/2.55)**(5.8)
    else:
        lowMargin = .005

    # print(highMargin,lowMargin)
    
    bsFrac = 1
    lastI = 0
    count = 0
    

    for i in range(0, len(t1p)):

        

        if(i == 0):
            #initial buy
            
            s1Amount = 1 
            s2Amount = float(t1p[i])/float(t2p[i])
            
            s1 = s1Amount*float(t1p[i])
            s2 = s2Amount*float(t2p[i])
            initialBuy = s1+s2
            invested = s1+s2
            buyPow = 0
            print("initial buy at: {}".format(initialBuy))
            print("Bought {} shares of {} at the price of: {}".format(s1Amount, tick1, t1p[i]))
            print("Bought {} shares of {} at the price of: {}".format(s2Amount, tick2, t2p[i]))
            print("________________")
            
        
        list1.append((float(t1p[i])-float(t1p[0]))/float(t1p[0]))
        list2.append((float(t2p[i])-float(t2p[0]))/float(t2p[0]))

        
 
        if(list1[i]-list2[i] > highMargin and buySellBack == False):
            #sell from list1 buy from list2 
            list1Sold = True
            buySellBack = True
            s1 = s1Amount*float(t1p[i])-bsFrac*s1Amount*float(t1p[i])
            s2 = s2Amount*float(t2p[i])+bsFrac*s2Amount*float(t2p[i])
            invested = s1+s2
            buyPow += bsFrac*s1Amount*float(t1p[i]) - bsFrac*s2Amount*float(t2p[i])    
            count += 1

            print(i)
            print("Percent Change: {}".format(100*list1[i]-list2[i]))
            print("BUY & SELL")
            print("Sold {} at the price of: {}".format(tick1, t1p[i]))
            print("Bought {} at the price of: {}".format(tick2, t2p[i]))
            print("Invested: {}".format(invested))
            print("Buying Power: {}".format(buyPow))
            print("Total: {}".format(invested+buyPow))
            print("Profit: {}".format(invested+buyPow-initialBuy))
            print("________________")
            print()
        elif(list1[i]-list2[i] < -highMargin and buySellBack == False):
            #buy from list1 sell from list2
            list1Sold = False
            buySellBack = True
            s1 = s1Amount*float(t1p[i])+bsFrac*s1Amount*float(t1p[i])
            s2 = s2Amount*float(t2p[i])-bsFrac*s2Amount*float(t2p[i])
            invested = s1+s2
            buyPow += -bsFrac*s1Amount*float(t1p[i]) + bsFrac*s2Amount*float(t2p[i]) 
            count += 1
            print(i)
            print("Percent Change: {}".format(100*list1[i]-list2[i]))
            print("BUY & SELL")
            print("Bought {} at the price of: {}".format(tick1, t1p[i]))
            print("Sold {} at the price of: {}".format(tick2, t2p[i]))
            print("Invested: {}".format(invested))
            print("Buying Power: {}".format(buyPow))
            print("Total: {}".format(invested+buyPow))
            print("Profit: {}".format(invested+buyPow-initialBuy))
            print("________________")
            print()
        elif(abs(list1[i]-list2[i]) < lowMargin and buySellBack == True and list1Sold == True):
            #buy and sell back 
            buySellBack = False
            s1 = s1Amount*float(t1p[i])
            s2 = s2Amount*float(t2p[i])
            invested = s1+s2
            buyPow += -bsFrac*s1Amount*float(t1p[i]) + bsFrac*s2Amount*float(t2p[i])     
            count += 1
            print(i)
            print("Percent Change: {}".format(100*list1[i]-list2[i]))
            print("BUY & SELL BACK")
            print("Bought {} at the price of: {}".format(tick1, t1p[i]))
            print("Sold {} at the price of: {}".format(tick2, t2p[i]))
            print("Invested: {}".format(invested))
            print("Buying Power: {}".format(buyPow))
            print("Total: {}".format(invested+buyPow))
            print("Profit: {}".format(invested+buyPow-initialBuy))
            print("________________")
            print()
        elif(abs(list1[i]-list2[i]) < lowMargin and buySellBack == True and list1Sold == False):
            #buy and sell back 
            buySellBack = False
            s1 = s1Amount*float(t1p[i])
            s2 = s2Amount*float(t2p[i])
            invested = s1+s2
            buyPow += bsFrac*s1Amount*float(t1p[i]) - bsFrac*s2Amount*float(t2p[i])             
            count += 1
            print(i)
            print("Percent Change: {}".format(100*list1[i]-list2[i]))
            print("BUY & SELL BACK")
            print("Sold {} at the price of: {}".format(tick1, t1p[i]))
            print("Bought {} at the price of: {}".format(tick2, t2p[i]))
            print("Invested: {}".format(invested))
            print("Buying Power: {}".format(buyPow))
            print("Total: {}".format(invested+buyPow))
            print("Profit: {}".format(invested+buyPow-initialBuy))
            print("________________")
            print()
        
        lastI = i

    if buySellBack == False:
        buyPow += s1Amount*float(t1p[lastI]) + s2Amount*float(t2p[lastI]) 
    elif buySellBack == True and list1Sold == True:
        buyPow += s1Amount*float(t1p[lastI])-bsFrac*s1Amount*float(t1p[lastI]) + s2Amount*float(t2p[lastI])+bsFrac*s2Amount*float(t2p[lastI])
    elif buySellBack == True and list1Sold == False:
        buyPow += s1Amount*float(t1p[lastI])+bsFrac*s1Amount*float(t1p[lastI]) + s2Amount*float(t2p[lastI])-bsFrac*s2Amount*float(t2p[lastI])

    invested = 0
            
   
    growthw = 100*(invested+buyPow-initialBuy)/initialBuy
    growthwo = 100*(s1Amount*float(t1p[lastI]) + s2Amount*float(t2p[lastI])-initialBuy)/initialBuy

    print("{} {}, {}, {}, {}, {}, {}, {}, {}".format(tick1,tick2, count, growthw, growthwo, growthw-growthwo, invested+buyPow-initialBuy, initialBuy, sim))
    print("_______________________________________________________________________________")

    print("total profit w/algorithm: {}".format(invested+buyPow-initialBuy))
    print("annual growth w/algorithm: +%{}".format(growthw))
    print("------------------")
    print("total profit w/o algorithm: {}".format(s1Amount*float(t1p[lastI]) + s2Amount*float(t2p[lastI]) - initialBuy))
    print("annual growth w/o algorithm: +%{}".format(growthwo))
    print("Number of Trades: {}".format(count))
    
    



    

def similarity(tick1, tick2):
    stockString = tick1 + " " + tick2
    data = yf.download(stockString, start = "2019-01-27", end = "2020-01-27")
    t1p = data['Close'][tick1]
    t2p = data['Close'][tick2]
    list1 = []
    list2 = []
    
    for i in range(0, len(t1p)):
        list1.append((float(t1p[i])-float(t1p[0]))/float(t1p[0]))
        list2.append((float(t2p[i])-float(t2p[0]))/float(t2p[0]))
        
 

    return(spearmanr(list1,list2)[0])



if __name__ == '__main__':
    main()