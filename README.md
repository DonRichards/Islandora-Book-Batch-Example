# Islandora-Book-Batch-Example
This is an example of Islandora Book Batch data needed for testing or used as an example of how to setup a book's data for batch processing.

## How to use within islandora_vagrant
Copy test_book to the directory you're running vagrant from. From within islandora_vagrant is a /vagrant vagrant directory.

Run the instructions from [Islandora/islandora_book_batch](https://github.com/Islandora/islandora_book_batch)

### Example
```terminal
drush -v -u 1 --uri=http://localhost islandora_book_batch_preprocess --namespace=book --type=directory --scan_target=/vagrant/test_book

drush -v --user=admin --uri=http://localhost islandora_batch_ingest
```
