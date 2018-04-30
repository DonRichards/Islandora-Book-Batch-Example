# Islandora-Book-Batch-Example
This is an example of Islandora Book Batch data needed for testing or used as an example of how to setup a book's data for batch processing.

## How to use within islandora_vagrant
Clone this repo into the directory you're running vagrant from. From within islandora_vagrant the drupal will see their file location at /vagrant/Islandora-Book-Batch-Example/

Run the instructions from [Islandora/islandora_book_batch](https://github.com/Islandora/islandora_book_batch)

### Example
```terminal
cd /var/www/drupal

drush -v -u 1 --uri=http://localhost islandora_book_batch_preprocess --namespace=bookCollection --type=directory --scan_target=/vagrant/Islandora-Book-Batch-Example/

drush -v --user=admin --uri=http://localhost islandora_batch_ingest
```

### NOTE:
This will run in the /vagrant/Islandora-Book-Batch-Example/ directory and will see each directory as a book and all subdirectories as pages. This instructions are exact for islandora_vagrant and should work out of the box (copy paste should work right after islandora_vagrant completely starts).
