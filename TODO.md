2024-07-28 15:15:11 AGB

To automatically generate the self-study report:

You could apply this pattern:

make:

echo ... > file
docker exec ./file
cat header >> result
cat body >> result

done

