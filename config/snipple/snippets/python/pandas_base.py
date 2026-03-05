# base class for data analysis

import matplotlib.pyplot as plt
import pandas as pd
import pathlib
import glob
import os

current_file_path = pathlib.Path(__file__).parent.resolve()

class Analyzer:

    def __init__(self, path, output_dir="assets"):
        self.path = path
        self.output_dir = os.path.join(current_file_path, output_dir)
        if not os.path.exists(self.output_dir):
            os.makedirs(self.output_dir)
        self.load_and_augment_data()

    def load_and_augment_data(self):
        # read all csv files in the given path
        data = pd.concat([pd.read_csv(f) for f in glob.glob(os.path.join(self.path, '*.csv'))], ignore_index=True)

        # run some transformations on the data
        csv_df = pd.DataFrame(data)
        # creating a new empty data frame here that only holds the data we care
        # about
        df = pd.DataFrame()
        # parse creation time
        df['date'] = pd.to_datetime(csv_df['time'])

        print(df.tail(51))
        self.df = df


    def graph_things(self):
        df = self.df
        df.plot()
        plt.savefig('{}/graph.png'.format(self.output_dir))

    def run(self):
        self.graph_things()


if __name__ == "__main__":
    analyzer = Analyzer('{}/sources'.format(current_file_path))
    analyzer.run()
