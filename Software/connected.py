#from scipy.sparse.csgraph import connected_components
import matplotlib.pyplot as plt
import numpy as np
import random
import PixelClustering as PC

NUM_ROWS = 20
NUM_COLS = 20

x_range = np.array(range(NUM_ROWS))
y_range = np.array(range(NUM_COLS))

image = np.ones((NUM_ROWS, NUM_COLS))

x_coord = []
y_coord = []

for x in range(NUM_ROWS * NUM_COLS / 2):
    x_coord.append(random.randint(0, NUM_ROWS - 1))
    y_coord.append(random.randint(0, NUM_COLS - 1))

for coord in zip(x_coord, y_coord):
    image[coord[0], coord[1]] = 0

plt.imshow(image, cmap = 'gray', interpolation = 'none')
plt.show(block = True)

clustering = PC.PixelClustering(image)
clustering.find_clusters()

print "\nFINAL CLUSTERS:", clustering.get_clusters()

for k, v in clustering.get_clusters().items():
    color = np.random.rand()
    for (x,y) in v:
        image[x][y] = color

plt.imshow(image, cmap = 'Dark2', interpolation = 'none')
plt.show()

