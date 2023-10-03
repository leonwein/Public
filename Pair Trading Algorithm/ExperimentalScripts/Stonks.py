import click, json, time, math
import robin_stocks as rh
from matplotlib import pyplot as plt
import numpy as np

@click.group()
def main():
    content = open('config.json').read()
    config = json.loads(content)
    rh.login(config['username'], config['password'])




@main.command(help='backtest')
@click.option('--tick1', prompt = '1st ticker: ')
@click.option('--tick2', prompt = '2nd ticker: ')
def backtest(tick1, tick2):
    print(tick1, tick2)

    historyDict1 = rh.stocks.get_stock_historicals(tick1, interval = 'day', span = 'year', bounds = 'regular', info = None)
    historyDict2 = rh.stocks.get_stock_historicals(tick2, interval = 'day', span = 'year', bounds = 'regular', info = None)


    price1 = []
    price2 = []
    vol1 = []
    vol2 = []
    priceFrac = float(historyDict1[0]['close_price'])/float(historyDict2[0]['close_price'])
    test = [i for i in range(1,254)]




    #print(test)
    #print("______")
    #print(len(test))

    for i, hist in enumerate(historyDict1, start=0):
        
        price1.append(float(hist['close_price']))
        price2.append(float(historyDict2[i]['close_price'])*priceFrac)

        vol1.append(float(hist['volume']))
        vol2.append(float(historyDict2[i]['volume']))


    #print("volume of {} --- {}".format(tick1, vol1))

    #plt.plot(test, vol1, label='volume')
    #plt.plot(test, price1, label='price')
    #plt.xlabel("Time (days)")
    #plt.ylabel("price")
    #plt.legend()

    fig = plt.figure()
    ax1=fig.add_subplot(1,2,1)
    ax2=fig.add_subplot(1,2,2)
    ax1.plot(test, price1,label='price1')
    ax1.plot(test, price2, label = 'price2')
    ax2.plot(test, vol1, label='volume')
    ax1.set_xlabel('Time (D)')
    ax1.set_ylabel('price')
    ax1.set_title('Price over Year')
    ax1.legend()
    ax2.set_xlabel('Time (D)')
    ax2.set_ylabel('volume')
    ax2.set_title('volume over Year')
    ax2.legend()

    

    plt.show()


    #plt.plot([i for i in (1,254)], vol1)


if __name__ == '__main__':
    main()
