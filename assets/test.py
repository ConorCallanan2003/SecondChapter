import pandas as pd

df = pd.read_csv('books.csv', low_memory=False, sep=',')

df = df.drop(['book_id', 'goodreads_book_id',  'best_book_id',
             'work_id', 'books_count', 'isbn13', 'language_code', 'small_image_url', 'ratings_1', 'ratings_2', 'ratings_3', 'ratings_4', 'ratings_5', 'ratings_count', 'work_ratings_count', 'work_text_reviews_count', 'title'], axis=1)

df.to_csv('books__.csv', sep='{', index=False)

# df.to_csv('books.csv', sep='{', index=False)
