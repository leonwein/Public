AFTER SCRAPPING DATA, SHAPE IT INTO 3D BLOCK AND UPLOAD IT HERE!
TUTORIAL: 

    EXAMPLE/data_example_format_guide.ipynb

FILES (with matched names, data & data_description):

    BLOCKED_{data_name}_data.pkl
    BLOCKED_{data_name}_data_description.json

DATA SHAPE (numpy 3D array dimension):

    (47, N_FEATURE, 3142) 
        == 
    (N_MONTH, N_FEATURE, N_COUNTY)

DESCRIPTION FORMAT (dictionary):

    {
        'feature_0' : feature_name_0
        'feature_1' : feature_name_1
        ...
        'feature_n' : feature_name_n
    }

MONTHS:

    TOTAL:
        BEGIN MONTH:    Jul-19 == 2019-07
        END MONTH:      May-23 == 2023-05
        NUMBER OF MONTHS: 47

    TRAIN:
        BEGIN MONTH:    Jul-19 == 2019-07
        END MONTH:      Sep-22 == 2022-09
        NUMBER OF MONTHS: 39 

    TEST:
        BEGIN MONTH:    Oct-22 == 2022-10
        END MONTH:      May-23 == 2023-05
        NUMBER OF MONTHS: 8



