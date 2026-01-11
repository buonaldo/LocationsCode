// Base-34 alphabet (excludes 0 and 1 to avoid visual confusion)

function encodeLocationCode(lat, lon) {

    const BASE34_ALPHABET = "23456789ABCDEFGHJKLMNPQRSTUVWXYZ";
    var esito;
// 1) Check  the coordinates



    esito=Verify(lat, "latitude");
   if (esito!="OK") 
    {
        return esito;
    };

    esito=Verify(lon, "longitude");
   if (esito!="OK") 
    {
        return esito;
    };

  
// 2) Remove negative values
  let phiPrime = parseFloat(lat) + 90;
  let lambdaPrime = parseFloat(lon) + 180;

// 3) Convert to arc seconds
  let latSec = Math.round(phiPrime * 3600);
  let lonSec = Math.round(lambdaPrime * 3600);
 


  let latCode = Base34(latSec);
  let lonCode = Base34(lonSec);

// 4) Character interleaving: alternate latCode and lonCode
  let combined = "";
  const maxLen = Math.max(latCode.length, lonCode.length);
  for (let i = 0; i < maxLen; i++) {
    if (i < latCode.length) combined += latCode[i];
    if (i < lonCode.length) combined += lonCode[i];
  }

// Inserts a middle dash (optional, just for readability)
  let mid = Math.ceil(combined.length / 2);
  let mycode=combined.slice(0, mid) + "-" + combined.slice(mid);

  return mycode;
}

function Verify(v1,tipo)
{
	// 1) It must not be empty
    var esito="OK";
	if (v1 == null || v1 == undefined || v1 == "" ) 
	{ 
	     esito= "The value " + tipo + " cannot be empty o .";       
	} 
	
	// Convert to string for controls
	const str = String(v1); 
	// 2) Decimals must be separated by a period, not a comma. 
	if (str.includes(",")) 
	{ 
		esito = "Decimal in " + tipo + " must be separated by a period, not a comma"; 
	} 
	
	
	// 3) Check if it is a valid number 
	if (isNaN(str)) 
	{ 
	    esito="The value entered in " + tipo + " is invalid."; 
	}

    if ((v1 < -90 || v1 > 90) && tipo == "latitudine")
    {
        esito="the latitude value must be between -90 and 90"; 
    }

     if ((v1 < -180 || v1 > 180) && tipo == "longitudine")
    {
        esito="the longitude value must be between -180 and 180"; 
    }


	return esito;

   

}

function Base34(v1) 
{
    const code = ["2","3","4","5","6","7","8","9","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"];
    let result = "";

    for (let i = 0; i <= 3; i++) 
    {
        const b = 3 - i;
        const c1 = Math.floor(v1 / (34 ** b));
        result += code[c1];
        v1 = v1 - c1 * (34 ** b);
    }

    return result;
}







function GoMaps(code) 
{
    //Display Google Map by analyzing a Location Code

    //Alphabet is 2-9, A-Z 
    const BASE34_ALPHABET = "23456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  // remove separator
  let raw = code.replace("-", "");

  // eliminate interleaving
  let latChars = "";
  let lonChars = "";
  
  for (let i = 0; i < raw.length; i++) 
  {
    if (i % 2 === 0) latChars += raw[i];
    else lonChars += raw[i];
  }
  

  // Function to convert from base-34 to number
  const fromBase34 = (str) => 
  {
    return str.split("").reduce((acc, c) => 
    {
      return acc * 34 + BASE34_ALPHABET.indexOf(c);
    }, 0);
  };

  let latSec = fromBase34(latChars);
  let lonSec = fromBase34(lonChars);


  // Return to normalized coordinates
  let phiPrime = latSec / 3600;
  let lambdaPrime = lonSec / 3600;

  // 1) Subtract constants to return decimal degrees
  let latitude = phiPrime - 90;
  let longitude = lambdaPrime - 180;
  
  let lat=latitude.toFixed(6);
  let lon=longitude.toFixed(6);
  
	let mylink="https://www.google.com/maps?q=" + lat + ',' + lon;
	  
 
	
  window.open(mylink,"_blank");
	
  return { latitude, longitude };
 
}

function showAlert(title, message) {
  //Use a personalized alert
  document.getElementById('alertTitle').innerText = title;
  document.getElementById('alertMessage').innerText = message;
  document.getElementById('customAlert').style.display = 'flex';
}

function closeAlert() {
  document.getElementById('customAlert').style.display = 'none';
}