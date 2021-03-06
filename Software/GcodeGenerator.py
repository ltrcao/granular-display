import PixelClustering as PC
from operator import itemgetter

class GcodeGenerator:
    def __init__(self, clusters):
        self._clusters = clusters
        self._FEED_RATE = 20000
        self._CELL_WIDTH_MM = 10
        self._WALL_WIDTH_MM = 10
        self._X_OFFSET = 120
        self._Y_OFFSET = 80

    def generate_simple_cmds(self, filename):
        with open(filename, 'w') as f:
            for v in self._clusters.values():
                sorted_v = sorted(v, key = itemgetter(0,1))
                
                for x,y in sorted_v:
                    f.write('g1 x' + str(x * self._CELL_WIDTH_MM + self._X_OFFSET) + \
                            ' y' + str(y * self._CELL_WIDTH_MM + self._Y_OFFSET) + \
                            ' f' + str(self._FEED_RATE) + '\n')
                    f.write('m17\n')
                    f.write('g1 x' + str((x * self._CELL_WIDTH_MM) + self._X_OFFSET + .5) + \
                            ' y' + str(y * self._CELL_WIDTH_MM + self._Y_OFFSET) + \
                            ' f1\n')
                    f.write('g1 x' + str(x * self._CELL_WIDTH_MM + self._X_OFFSET) + \
                            ' y' + str(y * self._CELL_WIDTH_MM + self._Y_OFFSET) + \
                            ' f1\n')
                    f.write('m16\n')


    
                            
