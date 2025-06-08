<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

$conn = mysqli_connect('localhost', 'root', '', 'akademik');

if (!$conn) {
    echo json_encode(['status' => 'error', 'message' => 'Database connection failed']);
    exit();
}

$method = $_SERVER['REQUEST_METHOD'];

function getInput()
{
    parse_str(file_get_contents("php://input"), $data);
    return $data;
}

switch ($method) {
    case 'GET':
        if (isset($_GET['nim'])) {
            $nim = $_GET['nim'];
            $query = "SELECT * FROM mahasiswa WHERE nim='$nim'";
            $hasil = mysqli_query($conn, $query);
            $data = mysqli_fetch_assoc($hasil);

            if ($data) {
                echo json_encode($data);
            } else {
                echo json_encode(['status' => 'error', 'message' => 'Data tidak ditemukan']);
            }
            break;
        }else{
            $query = "SELECT * FROM mahasiswa";
            $hasil = mysqli_query($conn, $query);
            $tampung = [];
    
            while ($data = mysqli_fetch_assoc($hasil)) {
                $tampung[] = $data;
            }
    
            echo json_encode($tampung);
            break;
        }


    case 'POST':
        $nim = $_POST['nim'];
        $name = $_POST['name'];
        $sex = $_POST['sex'];
        $enroll = $_POST['enroll'];

        $query = "INSERT INTO mahasiswa (nim, name, sex, enroll) VALUES ('$nim', '$name', '$sex', '$enroll')";
        $result = mysqli_query($conn, $query);

        if ($result) {
            echo json_encode(['status' => 'success', 'message' => 'Data berhasil ditambahkan']);
        } else {
            echo json_encode(['status' => 'error', 'message' => 'Gagal menambahkan data']);
        }
        break;

    case 'PUT':
        $input = getInput();
        $nim = $input['nim'];
        $name = $input['name'];
        $sex = $input['sex'];
        $enroll = $input['enroll'];

        $query = "UPDATE mahasiswa SET nim='$nim', name='$name', sex='$sex' , enroll='$enroll' WHERE nim='$nim'";
        $result = mysqli_query($conn, $query);

        if ($result) {
            echo json_encode(['status' => 'success', 'message' => 'Data berhasil diupdate']);
        } else {
            echo json_encode(['status' => 'error', 'message' => 'Gagal mengupdate data']);
        }
        break;

    case 'DELETE':
        $nim = $_GET['nim'] ?? '';

        if ($nim) {
            $query = "DELETE FROM mahasiswa WHERE nim='$nim'";
            $result = mysqli_query($conn, $query);

            if ($result) {
                echo json_encode(['status' => 'success', 'message' => 'Data berhasil dihapus']);
            } else {
                echo json_encode(['status' => 'error', 'message' => 'Gagal menghapus data']);
            }
            break;
        } else {
            echo json_encode(['status' => 'error', 'message' => 'NIM tidak ditemukan di URL']);
        }
        break;

    default:
        echo json_encode(['status' => 'error', 'message' => 'Metode tidak dikenali']);
        break;
}
