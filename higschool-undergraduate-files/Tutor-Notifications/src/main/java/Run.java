import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Scanner;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;

import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;

public class Run {

	public static final String ACCOUNT_SID = "ACce388875b6cf35c3164a490e2f46a008";
	public static final String AUTH_TOKEN = "9cbb7aea13f146d8c3160613cd7b54ed";
	private static Scanner scantxt;

	public static void main(String[] args) throws IOException, InterruptedException {

		System.setProperty("webdriver.chrome.driver", "D:\\Downloads\\chromedriver\\chromedriver.exe");
		WebDriver driver = new ChromeDriver();
		String tutorQ = "https://my.suu.edu/tutoringcenter#Waiting";
		String allActive = "https://my.suu.edu/tutoringcenter#AllActive";
		String selectLinkOpeninNewTab = Keys.chord(Keys.CONTROL,"t");
		String currentURL = null;
		driver.navigate().to(tutorQ);

		driver.findElement(By.cssSelector("#username")).sendKeys("leonweingartner");
		driver.findElement(By.cssSelector("#password")).sendKeys("Sirmuffinz256");
		driver.findElement(By.cssSelector("#fm1")).click();

		// wait till correct url is loaded
		while (currentURL != tutorQ) {
			currentURL = driver.getCurrentUrl();
			System.out.println(currentURL);
			if (currentURL.equals(tutorQ)) {
				System.out.println(currentURL);
				currentURL = tutorQ;
			}
			Thread.sleep(2000);
		}
		
		

		scantxt = new Scanner(new File("infoWhitelist.txt"));
		ArrayList<ArrayList<String>> tutorList = new ArrayList<ArrayList<String>>();
		ArrayList<String> tutorInfo = new ArrayList<String>();
		tutorList.add(tutorInfo);
		int tutorCount = 0;
		while (scantxt.hasNextLine()) {
			String line = scantxt.nextLine();
			if (line.equals("")) {
				if (scantxt.hasNextLine()) {
					tutorInfo = new ArrayList<String>();
					tutorList.add(tutorInfo);
				}

			} else {
				tutorInfo.add(line);
			}

		}
		tutorCount = tutorList.size();
		System.out.println(tutorCount);
		System.out.println(tutorList);
		
		((JavascriptExecutor)driver).executeScript("window.open()");
	    ArrayList<String> tab = new ArrayList<String>(driver.getWindowHandles());

		ArrayList<String> classidListPH = new ArrayList<String>();
		ArrayList<String> checkClassidList = new ArrayList<String>();
		ArrayList<String> phoneNumbers = new ArrayList<String>();
		ArrayList<String> tutorBlock = new ArrayList<String>();
		
		
		while (true) {
			
			int countXpathidWaiting = 1;
			int onQCount = 0;
			int spaceCount = 0;
			String infoTxt = "";
			ArrayList<String> onQ = new ArrayList<String>();
			ArrayList<String> classidList = new ArrayList<String>();
			
			ArrayList<String> occNames = new ArrayList<String>();
			int countXpathidActive = 1;
			
			while (driver
					.findElements(By.xpath("//*[@id=\"Waiting\"]/div[" + countXpathidWaiting + "]/div/div[1]/strong/small"))
					.size() != 0) {
				WebElement element1 = driver.findElement(
						By.xpath("//*[@id=\"Waiting\"]/div[" + countXpathidWaiting + "]/div/div[1]/strong/small"));
				String nameid = element1.getText() + " ";
				WebElement element2 = driver
						.findElement(By.xpath("//*[@id=\"Waiting\"]/div[" + countXpathidWaiting + "]/div/div[2]/small"));
				String classAndProfid = element2.getText() + " ";
				WebElement element3 = driver
						.findElement(By.xpath("//*[@id=\"Waiting\"]/div[" + countXpathidWaiting + "]/div/div[3]/small"));
				String locationid = element3.getText() + " ";
				WebElement element4 = driver
						.findElement(By.xpath("//*[@id=\"Waiting\"]/div[" + countXpathidWaiting + "]/div/div[4]/small"));
				String timeid = element4.getText();

				for (int i = 0; i < classAndProfid.length(); i++) { // finds class id and puts into classidList array
					if (classAndProfid.charAt(i) == ' ') {
						spaceCount++;
						if (spaceCount == 2) {
							String classid = classAndProfid.substring(0, i);
							classidList.add(classid);
							spaceCount = 0;
							break;
						}
					}
				}

				infoTxt = nameid + classAndProfid + locationid + timeid;
				onQ.add(infoTxt);
				countXpathidWaiting += 2;
				onQCount++;

			}
			
			driver.switchTo().window(tab.get(1));
			driver.get(allActive);
			while (driver
					.findElements(By.xpath("//*[@id=\"AllActive\"]/div[" + countXpathidActive + "]/div/div[3]/small[1]"))
					.size() != 0) {
				WebElement element1 = driver.findElement(
						By.xpath("//*[@id=\"AllActive\"]/div[" + countXpathidActive + "]/div/div[3]/small[1]"));
				String nameidActive = element1.getText();
				
				occNames.add(nameidActive);
				countXpathidActive += 2;
						}
			System.out.println(occNames);
			driver.navigate().refresh();
			
			
			driver.switchTo().window(tab.get(0));
			driver.get(tutorQ);
			
			
			classidListPH = (ArrayList<String>) classidList.clone();
			classidList.removeAll(checkClassidList);
//			for (int n = 0; n < checkClassidList.size(); n++) {
//				if (checkClassidList.size() != 0 && classidList.size() != 0) {
//					if (checkClassidList.get(n).equals(classidList.get(n))) {
//						classidList.remove(n);
//					}
//				}
//			}
			checkClassidList = (ArrayList<String>) classidListPH.clone();

			System.out.println(onQ);
			System.out.println(classidList);

			// information gathered after webscraping
			if (classidList.size() != 0) {
				for (int j = 0; j < classidList.size(); j++) {
					//

					for (int i = 0; i < tutorCount; i++) { // checks list of lists for matching class id
						tutorBlock = tutorList.get(i);
						for (int k = 0; k < tutorBlock.size(); k++) {
							if (tutorBlock.get(k).equals(classidList.get(j)) && !occNames.contains(tutorBlock.get(0))) {
								phoneNumbers.add(tutorBlock.get(1));
								break;
							}
						}

					}

				System.out.println(phoneNumbers);


					Twilio.init(ACCOUNT_SID, AUTH_TOKEN);

					for (int m = 0; m < classidListPH.size(); m++) {
						if (classidList.get(j).equals(classidListPH.get(m))) {
							for (int l = 0; l < phoneNumbers.size(); l++) {
								Message message = Message
										.creator(new PhoneNumber(phoneNumbers.get(l)), new PhoneNumber("+14352339884"),
												onQ.get(m))
										.create(); // onQ.get(m)
								System.out.println(message.getSid());
							}
							break;
						}
					}
					phoneNumbers.clear();
				}
			}
			occNames.clear();
			System.out.println("____________");
			driver.navigate().refresh();

		}

	}

}
