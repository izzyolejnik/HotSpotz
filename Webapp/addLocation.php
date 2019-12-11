<?php

    $inData = getRequestInfo();
    $name = $inData["Name"];
    $address = $inData["Address"];
    $phone = $inData["Phone"];
    $review = $inData["Review"];
    $verified = 0;
    
	$conn = new mysqli("localhost", "guest", "guest123", "HotSpotz");
	if ($conn->connect_error) 
	{
		returnWithError( $conn->connect_error );
	} 
	else
	{
		$sql = $conn->prepare("INSERT INTO Locations (Name, Address, Phone, Review, Verified) VALUES (?,?,?,?,?)");
        $sql->bind_param("sssdi", $name, $address, $phone, $review, $verified);
		$sql->execute();

		$conn->close();
		returnWithInfo("Successful Add");
	}
	
	// receive the contact info to be added
	function getRequestInfo()
	{
		return json_decode(file_get_contents('php://input'), true);
	}

	// send result as json
	function sendResultInfoAsJson( $obj )
	{
		header('Content-type: application/json');
		echo $obj;
	}
	
	// format return info as json
	function returnWithInfo($send)
	{
		$retVal = '{"results":"' . $send . '"}';
		sendResultInfoAsJson($retVal);
	}

	// return error as json
	function returnWithError($err)
	{
		$retVal = '{"error":"' . $err . '"}';
		sendResultInfoAsJson($retVal);
	}
?>