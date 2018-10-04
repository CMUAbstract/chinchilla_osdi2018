import pandas as pd

class BlockMap:
    def __init__(self, filename):
        self.block_map = {}

        d = pd.read_csv(filename)

        for idx, row in d.iterrows():
            func, block_name, block_hash = row['func'], row['block_name'], row['block_hash']
            if block_hash not in self.block_map:
                self.block_map[block_hash] = []
            self.block_map[block_hash].append((func, block_name))

    def hashes(self):
        return self.block_map.keys()

    def __get__(self, idx):
        return self.block_map[idx]

    def __iter__(self):
        return self.block_map.__iter__()

    def __next__(self):
        return self.block_map.__next__()

    def items(self):
        return self.block_map.items()

