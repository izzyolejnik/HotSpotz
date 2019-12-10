<?php
    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbname = "HotSpotz";
    $table = "Locations"; // Creates Table name Locations

    // Get actions from app to do operations in the database
    $action = $_POST["action"];
    //Create Connection
    $conn = new mysqli($servername, $username, $password, $dbname);
    // Check Connection
    if($conn->connect_error){
        die("Connection Failed: " . $conn->connect_error);
        return;
     }

     // If connection is OK
     // If app sends action to create table
     if("CREATE_TABLE" == $action){
         $sql = "CREATE TABLE IF NOT EXISTS $table (
         id INT (6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
         Name VARCHAR(30) NOT NULL,
         Address VARCHAR(30) NOT NULL,
         Phone VARCHAR(30),
         Category VARCHAR(30),
         Review DOUBLE(5, 2),
         ReviewCount INT (6),
         Distance DOUBLE(5, 2),
         Verified INT (1),
         )";

        if($conn->query($sql) == TRUE)
        {
           //success message
           echo "success";
        }
        else
        {
            echo "error";
        }
        $conn->close();
            return;
        }
      }

      // Next action is get location info from database
      if("GET_ALL" == $action)
      {
        $db_data = array();
        $sql = "SELECT id, Name, Address, Phone, Category, Review, ReviewCount, Distance, Verified from $table ORDER BY id DESC";
        $result = $conn->query($sql);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
            $db_data[] = $row;
            }
      // Send back the complete records as a json
      echo json_encode($db_data);
      }
      else
      {
        echo "error";
      }
      $conn->close();
      return;
      }




?>