# -*- coding: utf-8 -*-
"""
Created on Wed Jul 24 09:44:57 2024

@author: pc
"""
import pandas as pd
import numpy as np
import seaborn as sns
from scipy import stats
from statsmodels.stats.multitest import fdrcorrection
import matplotlib.pyplot as plt

from sklearn.model_selection import KFold
from sklearn.neural_network import MLPRegressor
from sklearn.metrics import r2_score
from sklearn.metrics import mean_absolute_error


df_age_features = pd.read_excel(r'E:\Scientific work\Work2\State coding\Brain age prediction.xlsx')
features,scores = df_age_features.iloc[:,:-1].values,df_age_features.iloc[:,-1].values

#Predict the age with ten-fold validation
predict_scores = np.zeros_like(scores)
kfold = KFold(n_splits = 10, shuffle=True,random_state=0)
for fold,(train,valid) in enumerate(kfold.split(features)):
    print('Fold:{:-^10}'.format(fold+1))
    xs = features[train,:]

    regr = MLPRegressor(random_state=1, max_iter=5000)
    regr.fit(xs,scores[train])
    
    x_valid = features[valid,:]
    predict_scores[valid] = regr.predict(x_valid)

r = stats.pearsonr(scores,predict_scores)
mae = mean_absolute_error(scores,predict_scores)
R2 = r2_score(scores,predict_scores)

df_scores = pd.DataFrame({'observation':scores,'prediction':predict_scores})
sns.set_theme(style="ticks",font_scale=1.5,font='arial')

font = {'family': 'arial',
        'weight': 'normal',
        'size': 18,
        }
ax = sns.lmplot(x = 'observation', y = 'prediction', data = df_scores, 
           scatter_kws={'linewidths':1,'edgecolor':'k','facecolor':'#B35C37','s':80},#336774 #B35C37
           line_kws = {'lw':2.5,'color':'#B35C37'})


ax.tick_params(direction='out', length=6, width=2,grid_alpha=0.5)
plt.xlabel('Prediction', fontdict = font)
plt.ylabel('Observation',fontdict = font)
font = {'family': 'arial',
        
        'weight': 'normal',
        'size': 14,
        }
plt.text(60,15,f'r = {r[0]:.2f}\nMAE = {mae:.2f}\nR$^{2}$ = {R2:.2f}',fontdict = font)

#Plot the correlations between representations and age 
pearson_coef = [stats.pearsonr(features[:,i],scores)[0] for i in range(27)]
pearson_pvalue = [stats.pearsonr(features[:,i],scores)[1] for i in range(27)]
fdr_result = fdrcorrection(pearson_pvalue,0.01)

x= ['VIS1','SMN1','DAN1','VAN1','LIM1','FPN1','DMN1','BG1','Thal1',
    'VIS2','SMN2','DAN2','VAN2','LIM2','FPN2','DMN2','BG2','Thal2',
    'VIS3','SMN3','DAN3','VAN3','LIM3','FPN3','DMN3','BG3','Thal3']

y = pearson_coef
colors = ['#46156C','#84A2CE','#3B964E','#B172B3','#FFFDCA','#E1AF6D',
          '#B62D36','#4D5139','#949788']
plt.bar(x,y,width = 0.5,edgecolor = 'k',color = colors)
plt.tick_params(direction='out', length=6, width=1,grid_alpha=0.5)
plt.xticks([])