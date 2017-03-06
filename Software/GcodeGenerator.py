import PixelClustering as PC
from operator import itemgetter

class GcodeGenerator:
    def __init__(self, clusters):
        self._clusters = clusters
        self._feed_rate = 20000
        self._CELL_WIDTH_MM = 10
        self._WALL_WIDTH_MM = 10

    def generate_simple_cmds(self, filename):
        with open(filename, 'w') as f:
            for v in self._clusters.values():
                sorted_v = sorted(v, key = itemgetter(0,1))
                
                for x,y in sorted_v:
                    f.write('g1 x' + str(x * self._CELL_WIDTH_MM) + ' y' + str(y* self._CELL_WIDTH_MM) + ' f' + str(self._feed_rate) + '\n')
                    f.write('m17\n')
                    f.write('m16\n')


    
                            
