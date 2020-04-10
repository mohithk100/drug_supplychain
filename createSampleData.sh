
#!/bin/bash
CHAINCODE="$1"
if [ -z "$CHAINCODE" ]
then 
	echo "Please provide chaincode name"
	exit 1
fi

declare -a salts
declare -a suppliers
declare -a manufacturers
declare -a distributors
declare -a pharmacists
declare -a shipping_ids



generate_uid(){
	local uid="$(node -e "console.log(Math.random().toString(36).substring(7))")"
	echo "$uid"
}

generate_salt(){
	printf "\n\nCreating salt....."
	salts+=( "$1" )
	hurl invoke $CHAINCODE ${CHAINCODE}_createSalt "{\"id\":\"$1\",\"name\":\"$2\"}" -u "$3" -o "$4"
}

generate_suppliers(){
	printf "\n\nCreating supplier.....$3...$1"
	suppliers+=( "$1" )
	hurl invoke $CHAINCODE ${CHAINCODE}_createSupplier "{\"id\":\"$1\",\"address\":\"$2\",\"organizationName\":\"$3\",\"authorityNumber\":\"$4\",\"rawMaterialAvailable\":[]}" -u "$5" -o "$6"
}

generate_manufacturer(){
	printf "\n\nCreating manufacturer....."
	manufacturers+=( "$1" )
	hurl invoke $CHAINCODE ${CHAINCODE}_createManufacturer "{\"id\":\"$1\",\"address\":\"$2\",\"organizationName\":\"$3\",\"authorityNumber\":\"$4\",\"FDALicenseNumber\":\"$5\"}" -u "$6" -o "$7"
}

generate_distributor(){
	printf "\n\nCreating distributor....."
	distributors+=( "$1" )
	hurl invoke $CHAINCODE ${CHAINCODE}_createDistributor "{\"id\":\"$1\",\"address\":\"$2\",\"organizationName\":\"$3\"}" -u "$4" -o "$5"
}

generate_pharmacist(){
	printf "\n\nCreating pharmacist......."
	pharmacists+=( "$1" )
	hurl invoke $CHAINCODE ${CHAINCODE}_createPharmacist "{\"id\":\"$1\",\"address\":\"$2\",\"organizationName\":\"$3\",\"authorityNumber\":\"$4\"}" -u "$5" -o "$6"
}

fetchSalts() {
	printf "\n\nFetching salts....."
	hurl invoke $CHAINCODE ${CHAINCODE}_fetchSalts "$1" "$2" -u "$3" -o "$4"
}

getRawMaterialFromSupplier() {
	printf "\n\ngetting Raw Material from supplier....."
	hurl invoke $CHAINCODE ${CHAINCODE}_getRawMaterialFromSupplier "$1" "$2" "$3" -u "$4" -o "$5"
}

manufactureDrugs() {
	printf "\n\n Manufacturing drugs...."
	hurl invoke $CHAINCODE ${CHAINCODE}_manufactureDrugs "$1" "$2" "$3" "$4" $5 "$6" -u "$7" -o "$8"
}

shipProductsFromManufacturerToDistributor() {
	printf "\n\n shipping products from manufacturer to distriutor...."
	shipping_ids+=( "$4" )
	hurl invoke $CHAINCODE ${CHAINCODE}_shipProductsFromManufacturerToDistributor "$1" "$2" "$3" "$4" -u "$5" -o "$6"
}

receiveProductsFromManufacturerByDistributor() {
	printf "\n\n Receiving products from manufacturer by distributor...."
	hurl invoke $CHAINCODE ${CHAINCODE}_receiveProductsFromManufacturerByDistributor "$1" "$2" -u "$3" -o "$4"
}

exportProductsToPharmacist() {
	printf "\n\n Exporting products to pharmacist...."
	hurl invoke $CHAINCODE ${CHAINCODE}_exportProductsToPharmacist "$1" "$2" "$3" -u "$4" -o "$5"
}


{
	generate_salt "$(generate_uid)" "salt_1" "user1" "org2" &
	generate_salt "$(generate_uid)" "salt_2" "user1" "org1" &
	generate_salt "$(generate_uid)" "salt_3" "user1" "org1" &
	generate_salt "$(generate_uid)" "salt_4" "user1" "org1" &
	generate_salt "$(generate_uid)" "salt_5" "user1" "org2" &
}
wait

{
	generate_suppliers "$(generate_uid)" "supplier_address_1" "supplier_1" "supplier_an_1" "user1" "org1" &
	generate_suppliers "$(generate_uid)" "supplier_address_2" "supplier_2" "supplier_an_2" "user1" "org2" &
	generate_suppliers "$(generate_uid)" "supplier_address_3" "supplier_3" "supplier_an_3" "user1" "org2" &
	generate_suppliers "$(generate_uid)" "supplier_address_4" "supplier_4" "supplier_an_4" "user1" "org1" &
}
wait

{
	generate_manufacturer "$(generate_uid)" "manufacturer_address_1" "manufacturer_1" "manufacturer_an_1" "manufacturer_fda_1" "user1" "org1" &
	generate_manufacturer "$(generate_uid)" "manufacturer_address_2" "manufacturer_2" "manufacturer_an_2" "manufacturer_fda_2" "user1" "org2" &
	generate_manufacturer "$(generate_uid)" "manufacturer_address_3" "manufacturer_3" "manufacturer_an_3" "manufacturer_fda_3" "user1" "org1" &
}
wait

{
	generate_distributor "$(generate_uid)" "distributor_address_1" "distributor_1" "user1" "org2" &
	generate_distributor "$(generate_uid)" "distributor_address_2" "distributor_2" "user1" "org1" &
	generate_distributor "$(generate_uid)" "distributor_address_3" "distributor_3" "user1" "org2" &
}
wait

{
	generate_pharmacist "$(generate_uid)" "pharmacist_address_1" "pharmacist_1" "pharmacist_an_1" "user1" "org2" &
	generate_pharmacist "$(generate_uid)" "pharmacist_address_2" "pharmacist_2" "pharmacist_an_2" "user1" "org1" &
	generate_pharmacist "$(generate_uid)" "pharmacist_address_3" "pharmacist_3" "pharmacist_an_3" "user1" "org1" &
}
wait

# fetchSalts "${suppliers[0]}" "{\"${salts[0]}\":100,\"${salts[1]}\":90,\"${salts[2]}\":100,\"${salts[3]}\":50,\"${salts[4]}\":70}"
# fetchSalts "${suppliers[1]}" "{\"${salts[0]}\":90,\"${salts[1]}\":90,\"${salts[2]}\":100}"
# fetchSalts "${suppliers[2]}" "{\"${salts[0]}\":50,\"${salts[3]}\":60,\"${salts[4]}\":75}"
# fetchSalts "${suppliers[3]}" "{\"${salts[1]}\":90,\"${salts[2]}\":40}"


# getRawMaterialFromSupplier "${manufacturers[0]}" "${suppliers[0]}" "{\"${salts[0]}\":50,\"${salts[1]}\":40,\"${salts[2]}\":40,\"${salts[3]}\":10,\"${salts[4]}\":35}"
# getRawMaterialFromSupplier "${manufacturers[1]}" "${suppliers[1]}" "{\"${salts[0]}\":30,\"${salts[1]}\":40,\"${salts[2]}\"20}"
# getRawMaterialFromSupplier "${manufacturers[2]}" "${suppliers[3]}" "{\"${salts[1]}\":30,\"${salts[2]}\":10}"
# getRawMaterialFromSupplier "${manufacturers[2]}" "${suppliers[2]}" "{\"${salts[0]}\":20,\"${salts[4]}\":30}"


# manufactureDrugs "${manufacturers[0]}" "{\"${salts[0]}\":40,\"${salts[1]}\":20,\"${salts[2]}\":30,\"${salts[3]}\":10,\"${salts[4]}\":30}" "drug_1_man_1" "drug_gen_1" 10 "$(date +%Y-10-%d)"
# manufactureDrugs "${manufacturers[1]}" "{\"${salts[0]}\":30,\"${salts[1]}\":30,\"${salts[2]}\"20}" "drug_1_man_2" "drug_gen_2" 20 "$(date +%Y-12-%d)"
# manufactureDrugs "${manufacturers[2]}" "{\"${salts[0]}\":50,\"${salts[3]}\":60,\"${salts[4]}\":70}" "drug_1_man_3" "drug_gen_3" 50 "$(date +%Y-8-%d)"
# manufactureDrugs "${manufacturers[2]}" "{\"${salts[1]}\":20,\"${salts[2]}\":10}" "drug_2_man_3" "drug_gen_4" 15 "$(date +%Y-10-%d)"


# shipProductsFromManufacturerToDistributor "${manufacturers[0]}" "${distributors[0]}" "drug_1_man_1" "shipping_id_$(generate_uid)"
# shipProductsFromManufacturerToDistributor "${manufacturers[1]}" "${distributors[1]}" "drug_1_man_2" "shipping_id_$(generate_uid)"
# shipProductsFromManufacturerToDistributor "${manufacturers[2]}" "${distributors[1]}" "drug_1_man_3" "shipping_id_$(generate_uid)"
# shipProductsFromManufacturerToDistributor "${manufacturers[2]}" "${distributors[2]}" "drug_2_man_3" "shipping_id_$(generate_uid)"


# receiveProductsFromManufacturerByDistributor "${distributors[0]}" "${shipping_ids[0]}"
# receiveProductsFromManufacturerByDistributor "${distributors[1]}" "${shipping_ids[1]}"
# receiveProductsFromManufacturerByDistributor "${distributors[1]}" "${shipping_ids[2]}"
# receiveProductsFromManufacturerByDistributor "${distributors[2]}" "${shipping_ids[3]}"























