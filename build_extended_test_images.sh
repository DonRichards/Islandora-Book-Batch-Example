#!/bin/bash

# clear the screen
clear
cat << "EOF"


    __   __   __           __       ___  __
    |__) /  \ /  \ |__/    |__)  /\   |  /  ` |__|
    |__) \__/ \__/ |  \    |__) /~~\  |  \__, |  |

       ___                 __        ___
      |__  \_/  /\   |\/| |__) |    |__
      |___ / \ /~~\  |  | |    |___ |___

                          ___  __
          |\/|  /\  |__/ |__  |__)
          |  | /~~\ |  \ |___ |  \


   This is makes image with variations to use for testing book ingestion.
   This creates folders for book page(s) testing

        [] Compressed TIFFs
        [] Compressed JP2s
        [] Images with Alpha Channels
        [] JPGs
        [] Zip files for each

        Compression setttings to test:
            None, BZip, Fax, Group4, JPEG, JPEG2000, Lossless, LZW, RLE and Zip.

EOF
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -

DIR=$(pwd)
compression_types=('None' 'BZip' 'Fax' 'Group4' 'JPEG' 'JPEG2000' 'Lossless' 'LZW' 'RLE' 'Zip')

# <-- cleanup function here -->
rm -rf pages_compression_test_tiffs
rm -rf pages_compression_test_jp2
rm -rf pages_alpha_channel_test
rm -rf *.zip

[[ -d "${DIR}/pages_compression_test_tiffs" ]] || mkdir pages_compression_test_tiffs
[[ -d "${DIR}/pages_compression_test_jp2" ]] || mkdir pages_compression_test_jp2
[[ -d "${DIR}/pages_alpha_channel_test" ]] || mkdir pages_alpha_channel_test

: '
Build a compressed image test

Testing:
    - None
    - BZip
    - Fax
    - Group4
    - JPEG
    - JPEG2000
    - Lossless
    - LZW
    - RLE
    - Zip
'

echo -e '\n\t\tMaking compressed tif images...\n'
for i in "${!compression_types[@]}"; do
  [[ -d "${DIR}/pages_compression_test_tiffs/${compression_types[i]}" ]] || mkdir pages_compression_test_tiffs/${i}
  convert -define tiff:ignore-layers=true -compress ${compression_types[i]} ${DIR}/test_book/1/OBJ.tiff ${DIR}/pages_compression_test_tiffs/${i}/Page_Compressed_${compression_types[i]}.tif 2> /dev/null
  identify -format %C ${DIR}/pages_compression_test_tiffs/${i}/Page_Compressed_${compression_types[i]}.tif
  echo -n -e "\t<-- compression for './pages_compression_test_tiffs/${i}/Page_Compressed_${compression_types[i]}.tif'\n"
done
echo -e '\n  Making tiffs for book > Pages > Zipped Pages zip file...\n'
zip -0 -qr ${DIR}/pages_compression_test_tiffs_zipped_pages.zip ${DIR}/pages_compression_test_tiffs
echo -n -e "\tdone\n\n"


echo -e '\n\t\tMaking compressed jp2 images...\n'
[[ -d "${DIR}/pages_compression_test_jp2" ]] || mkdir pages_compression_test_jp2
echo ''
for j in "${!compression_types[@]}"; do
  [[ -d "${DIR}/pages_compression_test_jp2/${compression_types[j]}" ]] || mkdir pages_compression_test_jp2/${j}
  convert -compress ${compression_types[j]} ${DIR}/uncompressed_jp2.jp2 ${DIR}/pages_compression_test_jp2/${j}/Page_Compressed_${compression_types[j]}.jp2 2> /dev/null
  identify -format %C ${DIR}/pages_compression_test_jp2/${j}/Page_Compressed_${compression_types[j]}.jp2
  echo -n -e "\t<-- compression for './pages_compression_test_jp2/${j}/Page_Compressed_${compression_types[j]}.jp2'\n"
done
echo -e '\n\t \\__ All JP2 may come back as JPEG2000. Not completely sure why __/\n'
echo -e '\n  Making jp2 for book > Pages > Zipped Pages zip file...\n'
zip -0 -qr ${DIR}/pages_compression_test_jp2s_zipped_pages.zip ${DIR}/pages_compression_test_jp2
echo -n -e "\tdone\n\n"

echo -e '\n\t\tMaking alpha channel images...\n'
[[ -d "${DIR}/pages_alpha_channel_test" ]] || mkdir pages_alpha_channel_test
convert -transparent white -fuzz 10% ${DIR}/test_book/1/OBJ.tiff ${DIR}/pages_alpha_channel_test/uncompressed_tiff_with_alpha_channel.tiff
convert -transparent white -fuzz 10% ${DIR}/test_book/1/OBJ.tiff ${DIR}/pages_alpha_channel_test/uncompressed_tiff_with_alpha_channel.tif
convert -transparent white -fuzz 10% ${DIR}/uncompressed_jp2.jp2 ${DIR}/pages_alpha_channel_test/uncompressed_jp2_with_alpha_channel.jp2
echo -e '\n  Making the alpha channel for book > Pages > Zipped Pages zip file...\n'
zip -0 -qr ${DIR}/pages_alpha_channel_test_zipped_pages.zip ${DIR}/pages_alpha_channel_test
echo -n -e "\tdone\n\n"

echo -e '\n  Making the test book zip file...\n'
zip -0 -qr ${DIR}/test_book_for_book_batch.zip ${DIR}/pages_alpha_channel_test
echo -n -e "\tdone\n\n"



echo -e "\n\n\nAll files created.\n\n\n"
