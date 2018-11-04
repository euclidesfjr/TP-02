#include <iostream>
#include "controller.hh"
#include "timestamp.hh"
#include <math.h>

using namespace std;

bool slow_start = true;
double the_window_size = 16.0;
double alfa = 0.25;
double beta = 0.125;

/* Default constructor */
Controller::Controller( const bool debug )
  : debug_( debug )
{}

/* Get current window size, in datagrams */
unsigned int Controller::window_size()
{
  /* Default: fixed window size of 100 outstanding datagrams */
  //unsigned int the_window_size = 100;
  if ( debug_ ) {
    cerr << "At time " << timestamp_ms()
	 << " window size is " << the_window_size << endl;
  }
  return the_window_size;
}

/* A datagram was sent */
void Controller::datagram_was_sent( const uint64_t sequence_number,
				    /* of the sent datagram */
				    const uint64_t send_timestamp,
                                    /* in milliseconds */
				    const bool after_timeout
				    /* datagram was sent because of a timeout */ )
{
  /* Default: take no action */
  if ( debug_ ) {
    cerr << "At time " << send_timestamp
	 << " sent datagram " << sequence_number << " (timeout = " << after_timeout << ")\n";
  }
}

/* An ack was received */
void Controller::ack_received( const uint64_t sequence_number_acked,
			       /* what sequence number was acknowledged */
			       const uint64_t send_timestamp_acked,
			       /* when the acknowledged datagram was sent (sender's clock) */
			       const uint64_t recv_timestamp_acked,
			       /* when the acknowledged datagram was received (receiver's clock)*/
			       const uint64_t timestamp_ack_received )
                               /* when the ack was received (by sender) */
{

/* Apresenta o RTT corrente */
uint64_t rtt = timestamp_ack_received - send_timestamp_acked;

if (rtt <= timeout_ms()){
	//Neste momento, o slow_star é executado, em relação à janela e o parâmetro alfa.
	if (slow_start){
	   the_window_size += alfa;
	}else{
	    //O mesmo ocorre com  o tamanho da janela, que recebe a divisão entre alva e o tamanho da janela, (congestion avoidance)
	    the_window_size += alfa/the_window_size;
	}
}else{
    slow_start = false;
	//Neste momento, ocorre a condicional para detectar o congestionamento
	//IMPLEMENTAÇÃO DA PREVENÇÃO DE CONGESTIONAMENTO
	the_window_size *= beta;
	if (the_window_size < 2) {
		the_window_size = 2.0;
	}
}

//CALCULA RTO 
// REFERENCIA ..: https://tools.ietf.org/html/draft-paxson-tcp-rto-00
/*  When the first RTT measurement R is made, the host MUST set

              SRTT <- R
              RTTVAR <- R/2
              RTO <- SRTT + K * RTTVAR

          where K = 4.
(2.3) When a subsequent RTT measurement R' is made, a host MUST set

              RTTVAR <- (1 - beta) * RTTVAR + beta * |SRTT - R'|
              SRTT <- (1 - alpha) * SRTT + alpha * R'

          The value of SRTT used in the update to RTTVAR is its value
          before updating SRTT itself using the second assignment.  That
          is, updating RTTVAR and SRTT MUST be computed in the above
          order.

          The above SHOULD be computed using alpha=1/8 and beta=1/4 (as
          suggested in [JK88]).

          After the computation, a host MUST update
          RTO <- SRTT + K * RTTVAR.



  /* Default: take no action */
  if ( debug_ ) {
    cerr << "At time " << timestamp_ack_received
	 << " received ack for datagram " << sequence_number_acked
	 << " (send @ time " << send_timestamp_acked
	 << ", received @ time " << recv_timestamp_acked << " by receiver's clock)"
	 << endl;
  }
}

/* How long to wait (in milliseconds) if there are no acks
   before sending one more datagram */
unsigned int Controller::timeout_ms()
{
  return 1000; /* timeout of one second */
}
