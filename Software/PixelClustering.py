from collections import defaultdict

class PixelClustering:
    def __init__(self, image):
        # image to be processed 
        self._image = image

        # all pixel clusters, cluster -> [(x, y)]
        self._clusters = defaultdict(list)
        self._num_clusters = 0

        self._adj_directions = [(1, 0), (1, 1), (0, 1), (1, -1)]
        
        # all potential pixels to add to clusters, (x, y) -> [cluster]
        self._potential_pixels = defaultdict(set)

        # all potential pixels, sorted by cluster, cluster -> [(x, y)]
        self._potential_pixels_by_cluster = defaultdict(set)
    ''' Finds all connected pixel clusters within image '''
    def find_clusters(self):
        for row in range(len(self._image)):
            for col in range(len(self._image[0])):
                #print "--- (" + str(row) + ", " + str(col) + ") ---"
                if self._image[row][col] == 0:
                    current_cluster = -1
                    if len(self._potential_pixels[(row, col)]) > 1:
                        self._num_clusters += 1
                        current_cluster = self._num_clusters
                        self._clusters[current_cluster].append((row, col))

                        merged_clusters = self._potential_pixels[(row, col)].copy()
			for c in merged_clusters:
				self._clusters[current_cluster] += self._clusters[c]
				for pp in self._potential_pixels_by_cluster[c]:
                                    self._potential_pixels_by_cluster[current_cluster].add(pp)
                                    self._potential_pixels[pp].add(current_cluster)
				del self._clusters[c]
				
                    
                    elif len(self._potential_pixels[(row, col)]) == 1:
                        current_cluster = self._potential_pixels[(row, col)].pop()
                        self._clusters[current_cluster].append((row, col))
			
                    else:
                        self._num_clusters += 1
                        self._clusters[self._num_clusters].append((row, col))
			current_cluster = self._num_clusters

                    for d in self._adj_directions:
			potential_pixel = (row + d[0], col + d[1])
			if (potential_pixel[0] >= 0 and potential_pixel[0] < len(self._image) and \
			    potential_pixel[1] >= 0 and potential_pixel[1] < len(self._image[0])):
                                #print "\tAdding " + str(potential_pixel) + " to potential pixels for cluster " + str(current_cluster)
				self._potential_pixels[potential_pixel].add(current_cluster)
                                self._potential_pixels_by_cluster[current_cluster].add(potential_pixel)
                                
		    del self._potential_pixels[(row, col)]
			
		else:
		    if len(self._potential_pixels[(row, col)]) >= 0:
			del self._potential_pixels[(row, col)]

		#print self._clusters
		#print self._potential_pixels
                    # if pixel in potential pixels, add to cluster
                        # if multiple clusters, merge clusters together
                    # else, create new cluster with pixel
                    
                    # add surrounding pixels to potential pixels with
                    # current cluster

    ''' Returns list of all pixels for all clusters '''
    def get_clusters(self):
        return self._clusters

    ''' Returns original image '''
    def get_image(self):
        return self._image

    
