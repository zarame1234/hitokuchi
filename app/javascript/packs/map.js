(g=>{var h,a,k,p="The Google Maps JavaScript API",c="google",l="importLibrary",q="__ib__",m=document,b=window;b=b[c]||(b[c]={});var d=b.maps||(b.maps={}),r=new Set,e=new URLSearchParams,u=()=>h||(h=new Promise(async(f,n)=>{await (a=m.createElement("script"));e.set("libraries",[...r]+"");for(k in g)e.set(k.replace(/[A-Z]/g,t=>"_"+t[0].toLowerCase()),g[k]);e.set("callback",c+".maps."+q);a.src=`https://maps.${c}apis.com/maps/api/js?`+e;d[q]=f;a.onerror=()=>h=n(Error(p+" could not load."));a.nonce=m.querySelector("script[nonce]")?.nonce||"";m.head.append(a)}));d[l]?console.warn(p+" only loads once. Ignoring:",g):d[l]=(f,...n)=>r.add(f)&&u().then(()=>d[l](f,...n))})({
  key: process.env.Maps_API_Key
  });
  
  let map;
  let markerCluster, markers = [];

  async function initMap() {
    const { Map } = await google.maps.importLibrary("maps");
    const {AdvancedMarkerElement} = await google.maps.importLibrary("marker") 
    
    map = new Map(document.getElementById("map"), {
      center: { lat: 35.681236, lng: 139.767125 }, 
      zoom: 15,
      mapId: "DEMO_MAP_ID",
      mapTypeControl: false
    });

    try {
      const response = await fetch("/posts.json");
      if (!response.ok) throw new Error('Network response was not ok');
  
      const { data: { items } } = await response.json();
      if (!Array.isArray(items)) throw new Error("Items is not an array");
  
      const infoWindows = [];

      items.forEach( item => {
        const latitude = item.latitude;
        const longitude = item.longitude;
        const shopName = item.shop_name;
        const postImage = item.image;
        const address = item.address;
        const body = item.body;
  
        const marker = new google.maps.marker.AdvancedMarkerElement ({
          position: { lat: latitude, lng: longitude },
          map,
          title: shopName,
        });
    
        const contentString = `
          <div class="information container map_post ">
            <div class="mb-1">
              <img class="thumbnail map_post_image" src="${postImage}" loading="lazy" >
            </div>
            <div>
              <h1 class="h6 font-weight-bold">${shopName}</h1>
              <p class="text-muted">${address}</p>
              <p class="fs-6">${body}</p>
              <a href="/posts/${item.id}" id="detailLink">詳細を見る</a>
            </div>
          </div>`;

        const infowindow = new google.maps.InfoWindow({
          content: contentString,
          ariaLabel: shopName,
        });
     
        marker.addListener("click", () => {
          infoWindows.forEach(info => info.close());
          infowindow.setContent(contentString);
          infowindow.open(map, marker);
        });

        google.maps.event.addListener(infowindow, 'domready', () => {
          document.getElementById('detailLink').addEventListener('click', (event) => {
            event.preventDefault();
            window.location.href = document.getElementById('detailLink').getAttribute('href');
        });
      });
  
        infoWindows.push(infowindow);
      });

    } catch (error) {
      console.error('Error fetching or processing post:', error);
    }
  }
  
initMap()

   