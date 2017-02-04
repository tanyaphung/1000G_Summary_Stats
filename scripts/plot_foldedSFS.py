import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

raw_data = {'bin': ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
        'YRI': [2823541, 1346176, 893528, 664841, 534290, 458990, 409236, 381802, 362756, 179552],
        'CEU': [1411196, 726723, 555064, 474588, 426348, 395389, 372470, 363900, 351204, 175544],
        'CHB': [1231307, 630529, 506478, 443129, 402558, 379631, 357628, 348659, 344224, 169514]}
df = pd.DataFrame(raw_data, columns = ['bin', 'YRI', 'CEU', 'CHB'])
df

# Setting the positions and width for the bars
pos = list(range(len(df['YRI'])))
width = 0.25

# Plotting the bars
fig, ax = plt.subplots(figsize=(10,5))

# Create a bar with YRI data,
# in position pos,
plt.bar(pos,
        #using df['YRI'] data,
        df['YRI'],
        # of width
        width,
        # with alpha 0.5
        alpha=0.5,
        # with color
        color='blue',
        # with label the first value in bin
        label=df['bin'][0])

# Create a bar with CEU data,
# in position pos + some width buffer,
plt.bar([p + width for p in pos],
        #using df['CEU'] data,
        df['CEU'],
        # of width
        width,
        # with alpha 0.5
        alpha=0.5,
        # with color
        color='red',
        # with label the second value in bin
        label=df['bin'][1])

# Create a bar with CHB data,
# in position pos + some width buffer,
plt.bar([p + width*2 for p in pos],
        #using df['CHB'] data,
        df['CHB'],
        # of width
        width,
        # with alpha 0.5
        alpha=0.5,
        # with color
        color='black',
        # with label the third value in bin
        label=df['bin'][2])

# Set the y axis label
ax.set_ylabel('Count')

# Set the chart's title
ax.set_title('Folded SFS')

# Set the position of the x ticks
ax.set_xticks([p + 1.5 * width for p in pos])

# Set the labels for the x ticks
ax.set_xticklabels(df['bin'])

# Setting the x-axis and y-axis limits
plt.xlim(min(pos)-width, max(pos)+width*4)
plt.ylim([0, 2850000])

# Adding the legend and showing the plot
plt.legend(['YRI', 'CEU', 'CHB'], loc='upper right')
plt.grid()
plt.show()