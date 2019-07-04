# Diese .py - Datei wurde automatisch aus dem IPython - Notebook (.ipynb) generiert.
# 
# Gelegentlich wurde ich von Teilnehmern gefragt, ob ich die Kursmaterialien nicht 
# auch als normale .py - Datien bereitstellen könne. Dadurch ist es möglich, den Code
# ohne Jupyter zu öffnen, beispielsweise wenn Python-Programme in einem Terminal oder in 
# Eclipse entwickelt werden.
# 
# Dem möchte ich hiermit nachkommen. Ich empfehle dir aber trotzdem, schau' dir lieber die
# IPython - Notebooks direkt an, oder den HTML-Export eben dieser. Dieser reine .py-Export
# ist meiner Meinung nach etwas unübersichtlich.


# coding: utf-8

# In[1]:


import pandas as pd

df = pd.read_csv("./classification.csv")

df.head()


# In[2]:


X = df[["age", "interest"]].values
y = df["success"].values


# In[3]:


from sklearn.model_selection import validation_curve, learning_curve
from sklearn.model_selection import RepeatedKFold
from sklearn.linear_model import LogisticRegression

from sklearn.ensemble import RandomForestClassifier

model = LogisticRegression()

model.fit(X, y)

import helper



# In[21]:


import matplotlib.pyplot as plt
import helper
import numpy as np

x = np.linspace(0, 1, 1000)
y1 = -(x - 0.5) ** 2
y2 = y1 - 0.3 + np.exp(x - 1)

fig, ax = plt.subplots()
ax.plot(x, y2, label = "Training")
ax.plot(x, y1, label = "Test")

ax.set_xlim(0, 1)
ax.set_ylim(-0.3, 0.5)
ax.legend()

ax.xaxis.set_major_formatter(plt.NullFormatter())
ax.yaxis.set_major_formatter(plt.NullFormatter())


