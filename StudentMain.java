package rs.etf.sab;

import java.lang.reflect.Method;

import java.lang.reflect.InvocationTargetException;
import java.util.List;
import student.ss170201_CityOperationsImpl;
import student.ss170201_CourierOperationsImpl;
import student.ss170201_CourierRequestOperationImpl;
import student.ss170201_DistrictOperationsImpl;
import student.ss170201_GeneralOperationsImpl;
import student.ss170201_PackageOperationsImpl;
import student.ss170201_UserOperationsImpl;
import student.ss170201_VehicleOperationsImpl;
import rs.etf.sab.operations.CityOperations;
import rs.etf.sab.operations.CourierOperations;
import rs.etf.sab.operations.CourierRequestOperation;
import rs.etf.sab.operations.DistrictOperations;
import rs.etf.sab.operations.GeneralOperations;
import rs.etf.sab.operations.PackageOperations;
import rs.etf.sab.operations.UserOperations;
import rs.etf.sab.operations.VehicleOperations;
import rs.etf.sab.test.CityOperationsTest;
import rs.etf.sab.test.DistrictOperationsTest;
import rs.etf.sab.test.PackageOperationsTest;
import rs.etf.sab.test.PublicModuleTest;
import rs.etf.sab.test.UserOperationsTest;
import rs.etf.sab.test.VehicleOperationsTest;
import rs.etf.sab.tests.TestHandler;
import rs.etf.sab.tests.TestRunner;



public class StudentMain {

	public static void main(String[] args){
		CityOperations cityOperations = new ss170201_CityOperationsImpl(); // Change this to your implementation.
		DistrictOperations districtOperations = new ss170201_DistrictOperationsImpl(); // Do it for all classes.
		CourierOperations courierOperations = new ss170201_CourierOperationsImpl(); // e.g. = new MyDistrictOperations();
		CourierRequestOperation courierRequestOperation = new ss170201_CourierRequestOperationImpl();
		GeneralOperations generalOperations = new ss170201_GeneralOperationsImpl();
		UserOperations userOperations = new ss170201_UserOperationsImpl();
		VehicleOperations vehicleOperations = new ss170201_VehicleOperationsImpl();
		PackageOperations packageOperations = new ss170201_PackageOperationsImpl();

		          TestHandler.createInstance(cityOperations, courierOperations, courierRequestOperation, districtOperations,
				generalOperations, userOperations, vehicleOperations, packageOperations);

		          TestRunner.runTests();
//            try {
//                PublicModuleTest pt = new PublicModuleTest(generalOperations, cityOperations, vehicleOperations, courierOperations, courierRequestOperation, userOperations, packageOperations, districtOperations);
//                Method[] allMethods = PublicModuleTest.class.getDeclaredMethods();
//                for (Method m : allMethods) {
//                    String mname = m.getName();
//                    if (!mname.equals("insertPackageH")) {
//                        try {
//                            System.out.println("Invoking: " + mname);
//                            Object o = m.invoke(pt);
//                            System.out.format("%s() returned %b%n", mname, (Boolean) o);
//                        } catch (Exception e) {
//                            System.out.println("@@@");
//                            e.printStackTrace();
//                        }
//                    }
//                }
//            } catch (Exception e) {
//            System.out.println("@@@");
//            e.printStackTrace();
//        }
                //courierOperations.deleteCourier("fica");
                //courierOperations.deleteCourier("stevan");
                //courierRequestOperation.insertCourierRequest("stevan", "BG1011AC");
                //boolean cond = courierRequestOperation.grantRequest("stevan");
               
                //for(String i: list){
                    //System.out.println("Prebacen u kurire? " + cond + "\n");
                //}
//                int idCity = cityOperations.insertCity("Belgrade", "11000");
//                districtOperations.insertDistrict("Palilula", idCity, 10, 10);
//                districtOperations.deleteAllDistrictsFromCity("Belgrade");

//            generalOperations.eraseAll();
//            int idCity = cityOperations.insertCity("Belgrade", "11000");
//            int idDistrict1 = districtOperations.insertDistrict("Palilula", idCity , 10, 10);
//            int idDistrict2 = districtOperations.insertDistrict("Vozdovac", idCity, 1, 10);
//            System.out.println("Prva opstina je : " + idDistrict1 + " , a druga opstina je : " + idDistrict2);
//            int retValue = districtOperations.deleteAllDistrictsFromCity("Belgrade");
//            System.out.println("Broj obrisanih opstina iz Beograda je : " + retValue);
            
            //boolean flag = districtOperations.deleteDistrict(idDistrict1);
            //System.out.println("Obrisana li je opstina ? " + flag);
            
//        generalOperations.eraseAll();
//        final String username = "crno.dete";
//        final String firstName = "Svetislav";
//        final String lastName = "Kisprdilov";
//        final String password = "sisatovac123";
//        //Assert.assertTrue(this.userOperations.insertUser(username, firstName, lastName, password));
//        if(userOperations.insertUser(username, firstName, lastName, password)){
//            System.out.println("Radi 111");
//        }
//        else{
//            System.out.println("Ne radi 111");
//        }
	}
}
