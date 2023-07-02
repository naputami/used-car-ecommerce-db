import csv

def save_to_csv(name, cols, rows):
    """
    A function for saving generated data to csv file

    Args:
    name (str) = csv file name
    cols (list) = column name
    rows (list) = generated data that will be inputted to table as rows

    return:
    -
    """
    with open(file= name, mode= 'w', newline= '' ) as csvfile:
        csv_dict_writer = csv.DictWriter(csvfile, fieldnames= cols)
        csv_dict_writer.writeheader()
        csv_dict_writer.writerows(rows)
