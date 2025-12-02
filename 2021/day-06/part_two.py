from part_one import load_data
from part_one import tick as tick_one
from typing import Dict, List

from scipy.optimize import curve_fit

import matplotlib.pyplot as plt

import numpy as np
import matplotlib.pyplot as plt
import decimal

from sklearn.linear_model import LinearRegression
from sklearn.preprocessing import PolynomialFeatures

from sklearn.gaussian_process import GaussianProcessRegressor
from sklearn.gaussian_process.kernels import DotProduct, WhiteKernel

from sklearn.ensemble        import RandomForestRegressor
from sklearn.model_selection import train_test_split

import xgboost as xgb


def convert_list_to_dic(data):
    rst = {
        0: data.count(0),
        1: data.count(1),
        2: data.count(2),
        3: data.count(3),
        4: data.count(4),
        5: data.count(5),
        6: data.count(6),
        7: data.count(7),
        8: data.count(8),
    }
    return rst 

def tick(rst):
    new_rst = {
        0: 0,
        1: 0,
        2: 0,
        3: 0,
        4: 0,
        5: 0,
        6: 0,
        7: 0,
        8: 0,
    }
    for x in rst:
        if x == 0:
            new_rst[6] += rst[x]
            new_rst[8] += rst[x]
        else:
            new_rst[x-1] += rst[x]
    return new_rst

def expon(x, a, b):
    return a*np.exp(b*x)

def power_law(x, a, b):
    return a*np.power(x, b)


def main():
    data = load_data(in_file="ex.txt")
    # rst  = convert_list_to_dic(data=data)
    
    rst = []
    days = range(0, 100)
    for day in days:
        data = tick_one(data=data)
        rst.append(len(data))
    
    y = np.asarray(rst, dtype=np.float128)
    x = np.asarray(days, dtype=np.float128)
    pars, cov     = curve_fit(f=expon, xdata=x, ydata=y, p0=[0,0], bounds=(-np.inf, np.inf))
    pars_2, cov_2 = curve_fit(f=expon, xdata=x, ydata=y, p0=[0,0], bounds=(-np.inf, np.inf), method="dogbox")
    # Now lets try some regression
    x_reg    = x.reshape(-1,1)
    y_reg    = y.reshape(-1,1)
    reg      = LinearRegression().fit(x_reg, y_reg)
    poly_reg = PolynomialFeatures(degree=9)
    x_poly   = poly_reg.fit_transform(x_reg)
    poly_reg.fit(x_poly, y_reg)
    lin_reg_2 = LinearRegression()
    lin_reg_2.fit(x_poly, y_reg)
    #plt.plot(x_reg, lin_reg_2.predict(poly_reg.fit_transform(x_reg)), color="pink")

    # Okay Gaussian regression
    kernel = DotProduct() + WhiteKernel()
    gpr    = GaussianProcessRegressor(kernel=kernel, random_state=0).fit(x_reg, y_reg)
    print(f"Gau: {gpr.score(x_reg, y_reg)}")
    print(gpr.predict(np.array([256]).reshape(-1,1)))

    # Random Forest?
    forest = RandomForestRegressor(
        n_estimators=200,
        max_depth=100,
        criterion="mse"
    )
    forest.fit(x_reg, y_reg)

    # FINE ill try xgboost
    # first convert the input into a special data type
    data_dmatrix = xgb.DMatrix(data=x_reg, label=y_reg)
    x_train, x_test, y_train, y_test = train_test_split(x_reg, y_reg)
    params_xg = {
            "colsample_bytree": 0.3,
            "learning_rate":    0.01,
            "max_depth":        5,
            "alpha":            10,
            "n_estimators":     10}
    xg_reg = xgb.XGBRegressor(colsample_bytree = 0.3, learning_rate = 0.01, max_depth=5, alpha = 10, n_estimators = 10)
    xg_reg.fit(x_train, y_train) 
    xg_reg_2 = xgb.train(x_reg, y_reg, num_boost_round=50)
    # xg_reg.fit(x_train, y_train) 
    print("#" * 80)
    print(xg_reg.predict(np.array([256]).reshape(-1,1)))
    print(xg_reg_2.predict(np.array([256]).reshape(-1,1)))
    print("#" * 80)

    print(f"RF: {forest.score(x_reg, y_reg)}")
    print(forest.predict(np.array([256]).reshape(-1,1))[0])
    print(f"Linear Reg: {reg.score(x_reg, y_reg)}")
    print(reg.predict(np.array([256]).reshape(-1,1))[0][0])
    print(f"poly Reg: {lin_reg_2.score(x_poly, y_reg)}")
    #print(lin_reg_2.predict(poly_reg.fit_transform(np.array([256]).reshape(-1,1)))[0][0])
    plt.scatter(x, y)
    plt.plot(x, expon(x, *pars))
    plt.plot(x, expon(x, *pars_2))
    plt.plot(x_reg, forest.predict(x_reg), color='green')
    plt.plot(x_reg, gpr.predict(x_reg), color='Red')
    plt.plot(x_reg, lin_reg_2.predict(poly_reg.fit_transform(x_reg)), color='blue')
    plt.show()
    print(f"expon guess: {expon(256, *pars)} -\t distance {26984457539 - expon(256, *pars)}")
    print(f"Linear guess: {reg.predict(np.array([256]).reshape(-1,1))[0][0]} -\t distance {26984457539 - reg.predict(np.array([256]).reshape(-1,1))[0][0]}")
    print(f"poly_guess: {lin_reg_2.predict(poly_reg.fit_transform(np.array([256]).reshape(-1,1)))[0][0]} -\t distance {26984457539 - lin_reg_2.predict(poly_reg.fit_transform(np.array([256]).reshape(-1,1)))[0][0]}")
    print(f"Random Forest Guess: {forest.predict(np.array([256]).reshape(-1,1))[0]} -\t\t distance {26984457539 - forest.predict(np.array([256]).reshape(-1,1))[0]}")

