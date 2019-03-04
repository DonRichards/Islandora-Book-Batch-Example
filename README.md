# Islandora-Book-Batch-Example
This is an example of Islandora Book Batch data needed for testing or used as an example of how to setup a book's data for batch processing.

## How to use within islandora_vagrant
Clone this repo into the directory you're running vagrant from. From within islandora_vagrant the drupal will see their file location at /vagrant/Islandora-Book-Batch-Example/

Create variations of the images/pages as tiffs, jp2s. This will create uncompressed, compressed and alpha channel images to test with. just run the build_extended_test_images.sh

Run the instructions from [Islandora/islandora_book_batch](https://github.com/Islandora/islandora_book_batch)

### Example
Example assumes you are using [islandora_vagrant](https://github.com/Islandora-Labs/islandora_vagrant) and have `$vagrant ssh` into the vagrant machine.  
```terminal
# clone this repo into /vagrant
cd /vagrant
git clone https://github.com/DonRichards/Islandora-Book-Batch-Example

cd /var/www/drupal

# This tells drush to put the Islandora-Book-Batch-Example book(s) into the collection name bookCollection
drush -v --user=admin --uri=http://localhost islandora_book_batch_preprocess --namespace=bookCollection --type=directory --target=/vagrant/Islandora-Book-Batch-Example/

drush -v --user=admin --uri=http://localhost islandora_batch_ingest
```

#### Example of multiple issues of a book
File structures like this tree view example would process each subdirectory as an issue into the same collection. They will display as different books within the same collection. 
```tree
/vagrant/Islandora-Book-Batch-Example/
├── test_book_issue_01
│   ├── 1
│   │   └── OBJ.tiff
│   ├── 2
│   │   └── OBJ.tif
│   ├── 3
│   │   └── OBJ.tif
│   └── MODS.xml
└── test_book_issue_02
    ├── 1
    │   └── OBJ.tiff
    ├── 2
    │   └── OBJ.tif
    ├── 3
    │   └── OBJ.tif
    └── MODS.xml

$ drush -v -u 1 --uri=http://localhost islandora_book_batch_preprocess --namespace=bookCollection --type=directory --target=/vagrant/Islandora-Book-Batch-Example/

```
### NOTE:
This will run in the /vagrant/Islandora-Book-Batch-Example/ directory and will see each directory as a book and all subdirectories as pages. This instructions are exact for islandora_vagrant and should work out of the box (copy paste should work right after islandora_vagrant completely starts).
